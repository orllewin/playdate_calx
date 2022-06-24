import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('GameOverScene').extends()

local onDismiss = nil

local sin <const> = math.sin
local cos <const> = math.cos

local playerRefs = {"Mortal", "Starfighter", "Loser", "Rebel Scum", "Warrior", "Sorcerer"}

local gameoverSample = playdate.sound.sampleplayer.new("audio/game_over_effect")

function GameOverScene:init(score)
	GameOverScene.super.init(self)
	
	self.score = score
	self.timer = playdate.timer.performAfterDelay(GAME_OVER_DISPLAY_MS, function() self:pop() end)
	
	local font = playdate.graphics.font.new('fonts/Roobert-11-Medium')
	graphics.setFont(font, "normal")
	
	self.messageA = "Game Over " .. playerRefs[ math.random( #playerRefs ) ] .. "!"
	self.messageAWidth = font:getTextWidth(self.messageA)
	self.mesageAX = (width - self.messageAWidth)/2
	
	self.messageB = "You scored: " .. self.score
	self.mesageBX = (width - font:getTextWidth(self.messageB))/2
	
	self.c = math.floor(height*1.2)/2
	
	self.nVals = {}
	for i=1,self.c  do
		self.nVals[i] = perlinNoise(i * 0.4, 1)
	end
	
	gameoverSample:play()
	
	--Tunnel
	self.frame = 0
end

function GameOverScene:pop()
		activeScene:clear()
		activeScene = SplashScene()
end

function GameOverScene:draw()
	background(black)
	
	playdate.timer.updateTimers()
	
	if(aPressed())then
		self.timer:remove()
		self:pop()
	end
	
	--Tunnel
	setWhite()
	fill2(0.3)
	
	for i=1,self.c  do
		local y = fastSqrt2(i*65, 5);
		local r = i * i * i / (height/4) / (height/4) / 2 + 40
		--local N = perlinNoise(i * 0.1 - f, 1) * 150 + f * 0.03
		local N = self.nVals[i] * 150 + self.frame * 0.03
		local xx = C.x + cos(N) * r
		local yy = y + sin(N) * r
		circle(xx, yy, i * 0.2)
	end
	self.frame += 1
	
	text(self.messageA, self.mesageAX, 100)
	text(self.messageB, self.mesageBX, 130)
end

function GameOverScene:clear()
	print("GameOverScene:clear()")
end