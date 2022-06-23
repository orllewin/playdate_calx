class('EnergyBar').extends()

function EnergyBar:init()
	self.energy = 400
end

function EnergyBar:setEnergy(energy)
	self.energy = energy
end

function EnergyBar:getEnergy()
	return self.energy
end

function EnergyBar:draw()
	playdate.graphics.fillRect(0, 0, self.energy, 12)
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeNXOR)
	playdate.graphics.drawText('Energy: ' .. self.energy, 5, 3)
	resetDrawMode()
end