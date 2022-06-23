--[[
		Hyperspace
--]] 

import 'Coracle/coracle'
import 'Coracle/vector'

class('Hyperspace').extends()
class('HyperspaceStar').extends()

local onHyperspaceDismiss = nil

function HyperspaceStar:init()
	 HyperspaceStar.super.init(self)
	 
	 local randomAngle = math.random() * TAU
	 local randomRadius = 65 * math.sqrt(math.random())
	 
	 local x = width/2 + (randomRadius * math.cos(randomAngle))
	 local y = height/2 + (randomRadius * math.sin(randomAngle))
	 
	 self.location = Vector(x, y)
	 self.terminus = Vector(-1, -1)
	 self.juvenille = true
	 self.expired = false
	 
	 local length = self.location:distance(C)
	 self.length = length
	 self.originalLength = length
end

function Hyperspace:init(starCount, _onHyperspaceDismiss)
	Hyperspace.super.init(self)
	onHyperspaceDismiss = _onHyperspaceDismiss
	self.stars = {}
	for i = 1, starCount do
		local star = HyperspaceStar()
		table.insert(self.stars, star)
	 end
end

function Hyperspace:draw()
	local expiredCount = 0
	for i = 1, #self.stars do
		local star = self.stars[i]
					
			local length = star.length
			
			local starX = star.location.x
			local starY = star.location.y
			
			if(star.juvenille)then
				local lengthAB = math.sqrt((C.x - starX)^2 + (C.y - starY)^2) 
				local xx = C.x + (starX - C.x) / lengthAB * length
				local yy = C.y + (starY - C.y) / lengthAB * length
				line(starX, starY,  xx,  yy)
				star.length = star.length + 2
				
				if(xx < 0 or xx > width or yy < 0 or yy > height)then
					star.juvenille = false
					star.terminus.x = xx
					star.terminus.y = yy
				end
			else
				local lengthAB = math.sqrt((C.x - starX)^2 + (C.y - starY)^2) 	
				local starTX = star.terminus.x
				local starTY = star.terminus.y
				
				local originalLength = star.originalLength

				local lengthAB = math.sqrt((C.x - starTX)^2 + (C.y - starTY)^2) 
				local xx = C.x + (starTX - C.x) / lengthAB * originalLength
				local yy = C.y + (starTY - C.y) / lengthAB * originalLength
				line(starTX, starTY,  xx,  yy)
				star.originalLength = star.originalLength + HYPERSPACE_RAY_EXIT_SPEED
				
				if(xx < 0 or xx > width or yy < 0 or yy > height)then
					star.juvenille = false
					star.expired = true
					star.terminus.x = xx
					star.terminus.y = yy
				end
				
				if(star.expired)then
					expiredCount = expiredCount + 1
				end
			end
	end
	
	if(expiredCount == #self.stars)then
		onHyperspaceDismiss()
	end
end

function normalizeAngle(a)
	if a >= 360 then a = a - 360 end
	if a < 0 then a = a + 360 end
	return a
end