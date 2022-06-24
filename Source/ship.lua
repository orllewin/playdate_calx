import "CoreLibs/sprites"

class('Ship').extends(playdate.graphics.sprite)

local shipDefault = playdate.graphics.image.new("images/ship_default")
local shipLeft = playdate.graphics.image.new("images/ship_bank_left")
local shipRight = playdate.graphics.image.new("images/ship_bank_right")

local shipDefaultShielded = playdate.graphics.image.new("images/ship_default_shielded")
local shipLeftShielded = playdate.graphics.image.new("images/ship_bank_left_shielded")
local shipRightShielded = playdate.graphics.image.new("images/ship_bank_right_shielded")

local shieldsUpSample = playdate.sound.sampleplayer.new("audio/shields_up_a")
local collisionSample = playdate.sound.sampleplayer.new("audio/collision")
local collisionShieldedSample = playdate.sound.sampleplayer.new("audio/shield_collision")

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
	
	self.shieldCount = 3
	self.shieldCollisionCount = 0
	self.shieldActive = false
	
	defaultRect.x = x - shipDefaultWidth/2
	defaultRect.y = y - shipDefaultHeight/2
	
	bankedRect.x = x - shipBankedWidth/2
	bankedRect.y = y - shipBankedHeight/2
end

function Ship:activateShield()
	if(self.shieldCount > 0)then	
			shieldsUpSample:play()		
			self:setImage(shipDefaultShielded)
			self.shieldCount -= 1
			self.shieldCollisionCount = 0
			self.shieldActive = true
			return true
		else
			return false
	end
end

function Ship:collision(damage)
	if(self.shieldActive) then
		--todo - active shield collision sound
		if(collisionShieldedSample:isPlaying() == false)then
			collisionShieldedSample:play()
		end
		
		self.shieldCollisionCount += 1
		
		--If ship's been hit 10 times turn shield off
		if(self.shieldCollisionCount >= 10)then
			self.shieldCollisionCount = 0
			self.shieldActive = false
			
			--reset sprite
			if(self.shipState == ShipState.default)then
				self:setImage(shipDefault)
			elseif (self.shipState == ShipState.left) then
				self:setImage(shipLeft)
			else
				self:setImage(shipRight)
			end
		end
	else
		self.energy = self.energy - damage
		if(collisionSample:isPlaying() == false)then
			collisionSample:play()
		end
	end
end

function Ship:getEnergy()
	return self.energy
end

function Ship:setEnergy(energy)
	self.energy = energy
end

function Ship:bankLeft()
	if(self.shipState ~= ShipState.left)then
		if(self.shieldActive)then
			self:setImage(shipLeftShielded)
			self.shipState = ShipState.left
		else
			self:setImage(shipLeft)
			self.shipState = ShipState.left
		end
	end
end

function Ship:bankRight()
	if(self.shipState ~= ShipState.right)then
		if(self.shieldActive)then
			self:setImage(shipRightShielded)
			self.shipState = ShipState.right
		else
			self:setImage(shipRight)
			self.shipState = ShipState.right
		end
	end
end

function Ship:straight()
	if(self.shipState ~= ShipState.default)then
		if(self.shieldActive)then
			self:setImage(shipDefaultShielded)
		else
			self:setImage(shipDefault)
		end
		self.shipState = ShipState.default
	end
end

function Ship:getHitRect()
	if(self.shipState == ShipState.default)then
		return defaultRect
	else
		return bankedRect
	end
end