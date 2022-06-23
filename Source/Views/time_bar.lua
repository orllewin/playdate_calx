class('TimeBar').extends()

function TimeBar:init(ms)
	self.time = ms
	self.start = playdate.getCurrentTimeMilliseconds()
end

function TimeBar:setEnergy(energy)
	self.energy = energy
end

function TimeBar:draw()
	local elapsed = playdate.getCurrentTimeMilliseconds() - self.start
	playdate.graphics.fillRect(0, 12, 400 - (400/self.time) * elapsed, 12)
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeNXOR)
	playdate.graphics.drawText('Time: ' .. math.floor((self.time - elapsed)/1000), 5, 15)
	resetDrawMode()
end