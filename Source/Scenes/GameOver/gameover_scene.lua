import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('GameOverScene').extends()

local onDismiss = nil

local playerRefs = {"Mortal", "Starfighter", "Hero", "Loser", "Rebel Scum", "Warrior", "Sorcerer"}

local gameoverSample = playdate.sound.sampleplayer.new("audio/game_over_effect")

function GameOverScene:init(score)
	GameOverScene.super.init(self)
	
	self.score = score
	self.background = playdate.graphics.image.new("images/splash_scene_background")
	self.timer = playdate.timer.performAfterDelay(GAME_OVER_TIME, function() self:pop() end)
	
	local font = playdate.graphics.font.new('fonts/Roobert-11-Medium')
	graphics.setFont(font, "normal")
	
	self.messageA = "Game Over " .. playerRefs[ math.random( #playerRefs ) ] .. "!"
	self.mesageAX = (width - font:getTextWidth(self.messageA))/2
	
	self.messageB = "You scored: " .. self.score
	self.mesageBX = (width - font:getTextWidth(self.messageB))/2
	
	gameoverSample:play()
end

function GameOverScene:pop()
		activeScene:clear()
		activeScene = SplashScene()
end

function GameOverScene:draw()
	background(black)
	self.background:draw(0, 0)
	
	text(self.messageA, self.mesageAX, 160)
	text(self.messageB, self.mesageBX, 190)
	
	playdate.timer.updateTimers()
end

function GameOverScene:clear()
	print("GameOverScene:clear()")
end