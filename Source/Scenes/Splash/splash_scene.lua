import 'CoreLibs/timer'
import 'Coracle/coracle'

class('SplashScene').extends()

function SplashScene:init()
	 SplashScene.super.init(self)
	 
	 self.splashImage = playdate.graphics.image.new("images/splash_scene_background")
	 
	 self.onSplashEnd = function()
		 activeScene:clear()
		 activeScene = StartScene()
	 end
	 
	 self.timer = playdate.timer.performAfterDelay(SPLASH_TIME, self.onSplashEnd)
	 
	 audio:playIntro()
	 
	 local font = playdate.graphics.font.new('fonts/Roobert-11-Medium')
	 graphics.setFont(font, "normal")
end

function SplashScene:draw()
	background(black)
	self.splashImage:draw(0, 0)
	
	if(aPressed())then
		self.timer:remove()
		self.onSplashEnd()
	end

	text("©2022 Orllewin", 10, 180)
	text("Music by Rolemusic", 10, 200)
	text("Powered by Coracle", 10, 220)
	
	playdate.timer.updateTimers()
end

function SplashScene:clear()
	print("SplashScene clear()")
end