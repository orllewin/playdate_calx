import "CoreLibs/sprites"
import 'Coracle/coracle'
import 'Coracle/Particles/starfield'
import 'Coracle/Particles/starbackground'
import 'ship'
import 'laser'
import 'Views/energy_bar'
import 'Views/time_bar'

class('Level1Scene').extends()

playdate.graphics.sprite.setBackgroundDrawingCallback(
	function( x, y, width, height )
		background(black)	
	end
)

local r = 50
local centerX = 200
local centerY = 120
local angle = 0
local backgroundAngle = 0

function normalizeAngle(a)
	if a >= 360 then a = a - 360 end
	if a < 0 then a = a + 360 end
	return a
end


function Level1Scene:init()
	 Level1Scene.super.init(self)

	 playdate.graphics.setColor(white)
	 
	 self.ship = Ship(200, 220)
	 self.ship:setEnergy(400)
	 self.ship:add()
	 
	 --Collision and Starfield
	 self.onCollision = function()
		 self.ship:collision(20)
		 
		 playdate.graphics.setColor(black)
		 fill(0.75)
		 circle(200, 220, 20)
		 playdate.graphics.setColor(white)
	 end
	 
	 self.starfield = Starfield(55, 2, 5, 0.02)
	 self.starfield:setCollisionListener(self.onCollision)
	 self.starBackground = StarBackground(100, 1)
	 self.energyBar = EnergyBar()
	 self.timeBar = TimeBar(1000 * 60)
	 self.laser = Laser(200, 220)
	 
	 --Screen font
	 local font = playdate.graphics.font.new("fonts/font-rains-1x")
	 playdate.graphics.setFont(font, "normal")
	 
	 audio:playLevel1()
end

function Level1Scene:gameOver()
	onGameOver()
end

function Level1Scene:draw()
	
	if(aPressed())then
		self.laser:fireBasic(playdate.getCrankPosition())
	end
	
	if(bPressed())then
		self.ship:setEnergy(0)
	end
	
	if(upRepeat())then
		self.starfield:up(1.5)
	end
	
	if(downRepeat())then
		self.starfield:down(1.5)
	end
	
	if(leftRepeat())then
		self.starfield:left(1.5)
	end
	
	if(rightRepeat())then
		self.starfield:right(1.5)
	end
	
	if(noDirectiontionalInput())then
		self.starfield:easeStraight(0.75)
	end
	
	local change = playdate.getCrankChange()
	
	if change ~= 0 then
		angle += change
		backgroundAngle += (change/3)
		backgroundAngle = normalizeAngle(backgroundAngle)	
		angle = normalizeAngle(angle)	
				
		if(change < 0 and math.abs(change) > 10)then
			self.ship:bankRight()
		end
		if(change > 0 and math.abs(change) > 10)then
			self.ship:bankLeft()
		end
		
	else
		self.ship:straight()
	end
	
	playdate.graphics.sprite.update()
	self.starBackground:draw(backgroundAngle)
	self.starfield:draw(angle, self.ship:getHitRect())
	self.laser:drawAll(change)
	self.energyBar:setEnergy(self.ship:getEnergy())
	self.energyBar:draw()
	self.timeBar:draw()
	
	if(self.energyBar:getEnergy() <= 0)then
			activeScene:clear()
			activeScene = GameOverScene()
	end
end

function Level1Scene:clear()
	audio:clear()
	print("todo - clear level 1 resources")
end