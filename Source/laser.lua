class('Beam').extends()

import 'Coracle/coracle'

local rad <const> = math.rad
local sin <const> = math.sin
local cos <const> = math.cos

function Beam:init(x, y, angle, speed)
	Laser.super.init(self)
	self.x = x
	self.y = y - 1
	self.angle = 0
	self.speed = speed
	self.distance = 0
	self.alive = true
	self.size = 4
end

class('Laser').extends()

function Laser:init(x, y)
	Laser.super.init(self)
	self.active = {}
	self.x = x
	self.y = y
end

function Laser:fireBasic(angle)
	local beam = Beam(self.x, self.y, angle, 1)
	table.insert(self.active, beam)
end

function Laser:drawAll(change)
	local i=1
	while i <= #self.active do
		local beam = self.active[i]
	
			local dx = beam.x - C.x
			local dy = beam.y - C.y
			
			--distance from bullet to screen centre
			local r = fastSqrt2(dx * dx + dy * dy, 6)
			
			r = r - beam.distance
			
			local targetDegrees = beam.angle - change
			local targetRadians = rad(targetDegrees)
			local xx = sin(targetRadians)
			local yy = cos(targetRadians)
			
			xx = (r * xx) + C.x
			yy = (r * yy) + C.y
			
			beam.distance = beam.distance + beam.speed
			beam.x = xx
			beam.y = yy
			beam.angle = targetDegrees
			
		circle(beam.x, beam.y, beam.size)
		
		if(beam.size > 1.06)then
			beam.size -= 0.06
		end
		
		if(beam.speed > 0.4)then
			beam.speed = beam.speed - 0.4
		end
		
		if r < 5 then
			table.remove(self.active, i)
		else
			i = i + 1
		end
	end
end

function normalizeAngle(a)
	if a >= 360 then a = a - 360 end
	if a < 0 then a = a + 360 end
	return a
end
