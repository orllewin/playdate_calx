--Global config
SPLASH_TIME = 2500
GAME_OVER_TIME = 5000
AUTO_START = false
SKIP_HYPERSPACE = true
ACCURATE_COLLISIONS = true

graphics = playdate.graphics
sound = playdate.sound

import 'Scenes/Splash/splash_scene'
import 'Scenes/Start/start_scene'
import 'Scenes/Hyperspace/hyperspace_scene'
import 'Scenes/Level1/level1_scene'
import 'Scenes/GameOver/gameover_scene'
import 'audio'

audio = Audio()
playAudio = true

restart = function()
	init()
end

function init()
	if(playAudio)then
		audio:playIntro()
	end
	
	activeScene = SplashScene()
end

init()

function playdate.update()
	activeScene:draw()
end

