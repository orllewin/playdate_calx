class('ScoreView').extends()

local floor <const> = math.floor

function ScoreView:init(x, y)
	self.score = 0.0
	self.x = x
	self.y = y
end

function ScoreView:addPoints(points)
	self.score += points
end

function ScoreView:getFinalScore()
	return floor(self.score)
end
	
	
function ScoreView:draw()
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeNXOR)
	playdate.graphics.drawText('Score: ' .. floor(self.score), self.x, self.y)
	resetDrawMode()
end