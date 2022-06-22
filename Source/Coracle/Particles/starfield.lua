--[[
		Starfield
--]] 

import 'Coracle/coracle'
import 'Coracle/vector'

class('Starfield').extends()
class('Star').extends()

local crankRad = 0
local collisionListener = nil

function Star:init(minSpeed, maxSpeed)
	 Star.super.init(self)
	 self.size = 1
	 self.location = Vector((math.random(-width/10, width/10)/2), math.random(-height/10, height/10))
	 self.rotatedLocation = Vector(self.location.x, self.location.y)
	 self.z = math.random(width/2)
	 self.speed = math.random(minSpeed, maxSpeed)
end

function Starfield:init(starCount, minSpeed, maxSpeed, sizeIncrement)
	Starfield.super.init(self)
	self.locus = Vector(width/4, height/4)
	self.sizeIncrement = sizeIncrement
	self.stars = {}
	for i = 1, starCount do
		local star = Star(minSpeed, maxSpeed)
		table.insert(self.stars, star)
	 end
end

function Starfield:setCollisionListener(_collisionListener)
	collisionListener = _collisionListener
end

function Starfield:collision()
	if(collisionListener ~= nil)then
		collisionListener()
	end
end

function Starfield:down(amount)
	if(self.locus.y > 0)then
		self.locus.y = self.locus.y - amount
	end
end

function Starfield:up(amount)
	if(self.locus.y < height/2)then
		self.locus.y = self.locus.y + amount
	end
end

function Starfield:left(amount)
	if(self.locus.x > 0)then
		self.locus.x = self.locus.x + amount
	end
end

function Starfield:right(amount)
	if(self.locus.x < width/2)then
		self.locus.x = self.locus.x - amount
	end
end

function Starfield:newVector(magnitude, angle)
	angle = (angle + 270) % 360 -- rotate -90° so that 0° is north instead of east
	local rad = math.rad(angle)
	local x = magnitude * math.cos(rad)
	local y = magnitude * math.sin(rad)
	return Vector(x, y)
end

function Starfield:easeStraight(amount)
	if(self.locus.x > width/4)then
		self.locus.x = self.locus.x - amount
	end
	
	if(self.locus.x < width/4)then
		self.locus.x = self.locus.x + amount
	end
	
	if(self.locus.y > height/4)then
		self.locus.y = self.locus.y - amount
	end
	
	if(self.locus.y < height/4)then
		self.locus.y = self.locus.y + amount
	end
end

function Starfield:draw(crankDegrees, shipRect)
	for i = 1, #self.stars do
		local star = self.stars[i]
		
		-- Draw
		local x = map(star.location.x/star.z, 0, 1, 0, width/2)
		local y = map(star.location.y/star.z, 0, 1, 0, height/2)
		local locusX = map(self.locus.x, 0, width/2, -width/2, width/2)
		local locusY = map(self.locus.y, 0, height/2, -height/2, height/2)
		
		local screenX = x - locusX + width/2
		local screenY = y - locusY + height/2
		
		local dx = screenX - C.x
		local dy = screenY - C.y
		
		--distance origin to star
		local r = fastSqrt(dx * dx + dy * dy)
		
		local currentRadians = math.atan2 ( C.y - screenY, screenX - C.x) 
		local currentDegrees = math.deg(currentRadians)
		local targetDegrees = currentDegrees + crankDegrees
		
		local targetRadians = math.rad(targetDegrees)
		local xx = math.sin(targetRadians)
		local yy = -1 * math.cos(targetRadians)
		
		xx = (r * xx) + C.x
		yy = (r * yy) + C.y
		
		if(star.z > width/3)then
			point(xx, yy)
		else
			circle(xx, yy, star.size)
		end
		
		--Check collision
		if(shipRect ~= nil and yy >= shipRect.y and yy < height)then
  		if(xx >= shipRect.x and xx <= shipRect.x + shipRect.width)then
    		if(ACCURATE_COLLISIONS)then
      		--ship point:
      		local x1 = shipRect.x + (shipRect.width/2)
      		local y1 = shipRect.y
      		
      		--bottom left
      		local x2 = shipRect.x
      		local y2 = shipRect.y + shipRect.height
      		
      		local sideLength = fastDistance(x1, y1, x2, y2)
       		
      		if (((xx - x1) * (y2 - y1) - (yy - y1) * (x2 - x1)) / sideLength <= star.size)then
        		self:collision()
					else
						--bottom right
						local x3 = shipRect.x + shipRect.width
						local y3 = shipRect.y + shipRect.height
						
						if (((xx - x1) * (y3 - y1) - (yy - y1) * (x3 - x1)) / sideLength <= star.size)then
							self:collision()
						end
      		end
    		else
      		self:collision()
    		end
  		end
		end
		
		
		--Update position
		star.z = star.z - star.speed
		star.size = star.size + self.sizeIncrement
						
		if(star.z <= 0) then
			star.z = math.random(width/2, width)
			star.location = Vector((math.random(-width/10, width/10)/2), math.random(-height/10, height/10))
			star.size = 1
		end
	end
end

function map(value, start1, stop1, start2, stop2)
	return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
end