import "CoreLibs/sprites"

class('Ship').extends(playdate.graphics.sprite)

local shipDefault = playdate.graphics.image.new("images/ship_default")
local shipLeft = playdate.graphics.image.new("images/ship_bank_left")
local shipRight = playdate.graphics.image.new("images/ship_bank_right")

local collisionSample = playdate.sound.sampleplayer.new("audio/collision")

local shipDefaultWidth, shipDefaultHeight = shipDefault:getSize()
local shipBankedWidth, shipBankedHeight = shipLeft:getSize()

local defaultRect = playdate.geometry.rect.new(0, 0, shipDefaultWidth, shipDefaultHeight)
local bankedRect = playdate.geometry.rect.new(0, 0, shipBankedWidth, shipBankedHeight)

ShipState = {default=0, left=1, right=2}

function Ship:init(x, y)
	Ship.super.init(self)
	self.energy = 400
	self.shipState = ShipState.default
	self:setImage(shipDefault)
	self:moveTo(x, y)
	
	defaultRect.x = x - shipDefaultWidth/2
	defaultRect.y = y - shipDefaultHeight/2
	
	bankedRect.x = x - shipBankedWidth/2
	bankedRect.y = y - shipBankedHeight/2
end

function Ship:collision()
	self.energy = self.energy - 5
	if(collisionSample:isPlaying() == false)then
		collisionSample:play()
	end
end

function Ship:getEnergy()
	return self.energy
end

function Ship:bankLeft()
	self:setImage(shipLeft)
	self.shipState = ShipState.left
end

function Ship:bankRight()
	self:setImage(shipRight)
	self.shipState = ShipState.right
end

function Ship:straight()
	self:setImage(shipDefault)
	self.shipState = ShipState.default
end

function Ship:getHitRect()
	if(self.shipState == ShipState.default)then
		return defaultRect
	else
		return bankedRect
	end
end