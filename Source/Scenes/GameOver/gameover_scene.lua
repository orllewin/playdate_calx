import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('GameOverScene').extends()

local onDismiss = nil

function GameOverScene:init(_onGameOverSceneDismiss)
	GameOverScene.super.init(self)
	
	if(_onGameOverSceneDismiss ~= nil)then
		onDismiss = _onGameOverSceneDismiss
	end
	
	self.background = playdate.graphics.image.new("images/game_over_scene_background")
	self.timer = playdate.timer.performAfterDelay(GAME_OVER_TIME, function() self:pop() end)
end

function GameOverScene:pop()
	if(onDismiss ~= nil)then
		onDismiss()
	else
		activeScene:clear()
		activeScene = SplashScene()
	end
	
end

function GameOverScene:draw()
	backgroundDark()
	self.background:draw(0, 0)
	
	playdate.timer.updateTimers()
end

function GameOverScene:clear()
	print("todo")
end