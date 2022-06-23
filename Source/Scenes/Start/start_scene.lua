import 'Coracle/coracle'

class('StartScene').extends()

function StartScene:init()
	 StartScene.super.init(self)
	 
	 self.onDismissStart = function()
		 activeScene:clear()
		 activeScene = HyperspaceScene("Level 1 - Get Ready!")
	 end
	 
	 self.startImage = playdate.graphics.image.new("images/splash_scene_background")

	 --Oldschool 3D
	 self.showCalxLogo = true
	 self.t = 0
	 self.donut = true
	 playdate.graphics.setColor(white)
end

local cos <const> = math.cos
local sin <const> = math.sin

function StartScene:draw()
	background(black)
	if(self.showCalxLogo)then
		self.startImage:draw(0, 0)
	end

	text("Press A to start", 10, 220)

	if(aPressed())then
		self:onDismissStart()
	end
	
	if(bPressed())then
		if(self.showCalxLogo)then
			self.showCalxLogo = false
		else
			self.showCalxLogo = true
		end
	end
	
	if(upPressed())then
		if(self.donut)then
			self.donut = false
		else
			self.donut = true
		end
	end
	
	if(AUTO_START)then
		self:onDismissStart()
	end
	
	--Oldschool 3D
	self.t += 0.05
	setWhite()
	fill(0.4)
	local donut = self.donut
	for i=90,0, -1  do

		local q = (i * i)
		local Q = sin(q)
		
		local b
		if(donut)then
			b = i % 6 + self.t + i
		else
			b = i % 6 + self.t
		end

		local p = i + self.t
		local z = 6 + cos(b) * 3 + cos(p) * Q
		local s = 70 / z / z
		
		circle((C.x * (z + sin(b) * 5 + sin(p) * Q) / z), (C.y + C.x * (cos(q)- cos(b+self.t))/z), s)
	end
	
	setWhite()
end

function StartScene:clear()
	print("todo - release resrouces from splash")
	audio:clear()
end