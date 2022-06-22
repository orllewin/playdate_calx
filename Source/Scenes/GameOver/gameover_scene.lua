import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('GameOverScene').extends()

local onDismiss = nil

function GameOverScene:init(message, _onGameOverSceneDismiss)
	GameOverScene.super.init(self)
	onDismiss = _onGameOverSceneDismiss
	self.background = playdate.graphics.image.new("images/game_over_scene_background")
	self.timer = playdate.timer.performAfterDelay(GAME_OVER_TIME, function() self:pop() end)
end

function GameOverScene:pop()
	onDismiss()
end

function GameOverScene:draw()
	self.background:draw(0, 0)
	
	playdate.timer.updateTimers()
end

function GameOverScene:clear()
	print("todo")
end