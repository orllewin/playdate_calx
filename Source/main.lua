import 'Scenes/Splash/splash_scene'
import 'Scenes/Start/start_scene'
import 'Scenes/Hyperspace/hyperspace_scene'
import 'Scenes/Level1/level1_scene'
import 'audio'

--Global config
SPLASH_TIME = 500
AUTO_START = true
SKIP_HYPERSPACE = true
ACCURATE_COLLISIONS = true

graphics = playdate.graphics
sound = playdate.sound

Scenes = {splash="0", start="00", level1="1", level2="2", gameover="98", gamecomplete="99"}
scene = Scenes.splash

audio = Audio()
playAudio = true

local level1IntroDismissed = function()
	print("level1IntroDismissed()")
	activeScene:clear()
	activeScene = Level1Scene()
	audio:playLevel1()
end

local startDismiss = function()
	print("Splash dismiss")
	activeScene:clear()
	audio:clear()
	activeScene = HyperspaceScene("Level 1 - Get Ready!", level1IntroDismissed)
end

local splashDismiss = function()
	print("Splash dismiss")
	scene = Scenes.start
	activeScene:clear()
	activeScene = StartScene(startDismiss)
end

activeScene = SplashScene(splashDismiss)

function init()
	if(playAudio)then
		audio:playIntro()
	end
end

init()

function playdate.update()
	activeScene:draw()
end

