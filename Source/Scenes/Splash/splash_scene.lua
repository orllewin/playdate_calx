import 'CoreLibs/timer'
import 'Coracle/coracle'

class('SplashScene').extends()

local onDismiss = nil

function SplashScene:init(onSplashDismiss)
	 SplashScene.super.init(self)
	 onDismiss = onSplashDismiss
	 self.splashImage = playdate.graphics.image.new("images/splash_scene_background")
	 self.timer = playdate.timer.performAfterDelay(SPLASH_TIME, function() self:pop() end)
	 
	 local font = playdate.graphics.font.new('fonts/Roobert-11-Medium')
	 graphics.setFont(font, "normal")
end

function SplashScene:pop()
	onDismiss()
end

function SplashScene:draw()
	self.splashImage:draw(0, 0)

	text("©2022 Orllewin", 10, 180)
	text("Music by Rolemusic", 10, 200)
	text("Powered by Coracle", 10, 220)
	
	
	playdate.timer.updateTimers()
end

function SplashScene:clear()
	print("todo")
end