--Global config
SPLASH_TIME = 2500
HYPERSPACE_RAY_EXIT_SPEED = 10
SURVIVAL_SCORE_INC = 0.02
AUTO_START = false
SKIP_HYPERSPACE = false
ACCURATE_COLLISIONS = true
PLAY_AUDIO = true

--Level 1 Config
LVL1_STAR_COUNT = 50
LVL1_STAR_MIN_SPEED = 2
LVL1_STAR_MAX_SPEED = 5
LVL1_STAR_SIZE_INC = 0.05
LVL1_STAR_MAX_SIZE = 5

--Game Over Config
GAME_OVER_DISPLAY_MS = 10000

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

