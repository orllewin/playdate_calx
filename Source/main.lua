--Global config
SPLASH_TIME = 2500
GAME_OVER_TIME = 5000
HYPERSPACE_RAY_EXIT_SPEED = 10
SURVIVAL_SCORE_INC = 0.02
AUTO_START = false
SKIP_HYPERSPACE = false
ACCURATE_COLLISIONS = true
PLAY_AUDIO = true

graphics = playdate.graphics
sound = playdate.sound

import 'Scenes/Splash/splash_scene'
import 'Scenes/Start/start_scene'
import 'Scenes/Hyperspace/hyperspace_scene'
import 'Scenes/Level1/level1_scene'
import 'Scenes/GameOver/gameover_scene'
import 'audio'

audio = Audio()
activeScene = SplashScene()

function playdate.update()
	activeScene:draw()
end

