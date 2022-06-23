import 'Coracle/coracle'
import 'Coracle/Particles/starfield'
import 'Coracle/Particles/starbackground'

class('StartScene').extends()

function StartScene:init()
	 StartScene.super.init(self)
	 
	 self.onDismissStart = function()
		 activeScene:clear()
		 activeScene = HyperspaceScene("Level 1 - Get Ready!")
	 end
	 
	 self.startImage = playdate.graphics.image.new("images/splash_scene_background")
	 self.degrees = 0
	 self.starBackground = StarBackground(60, 1)
	 self.starfield = Starfield(30, 4, 12, 0.07)
	 playdate.graphics.setColor(white)
end

function StartScene:draw()
	background()
	self.startImage:draw(0, 0)
	self.starBackground:draw(self.degrees)
	self.starfield:draw(self.degrees * -1)
	
	self.degrees = self.degrees += 2
	
	if(self.degrees >= 360)then
		self.degrees = 0
	end
	
	text("Press A to start", 10, 220)

	if(aPressed())then
		self:onDismissStart()
	end
	
	if(AUTO_START)then
		self:onDismissStart()
	end
end

function StartScene:clear()
	print("todo - release resrouces from splash")
end