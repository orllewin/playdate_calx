import "CoreLibs/sprites"
import 'Coracle/coracle'
import 'Coracle/Particles/starfield'
import 'Coracle/Particles/starbackground'
import 'ship'
import 'laser'
import 'Views/energy_bar'
import 'Views/time_bar'

class('Level1Scene').extends()


--Ship
local ship = Ship(200, 220)
ship:add()

--Energy
local energyBar = EnergyBar()

local timeBar = TimeBar(1000 * 60)

--Laser
local laser = Laser(200, 220)

--Starfield
onCollision = function()
	ship:collision()
	
	playdate.graphics.setColor(black)
	fill(0.75)
	circle(200, 220, 20)
	playdate.graphics.setColor(white)
end

local starfield = Starfield(35, 2, 5, 0.02)
starfield:setCollisionListener(onCollision)

--Star background
local starBackground = StarBackground(100, 1)

playdate.graphics.sprite.setBackgroundDrawingCallback(
	function( x, y, width, height )
		backgroundDark()	
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

local onGameOver = nil

function Level1Scene:init(_onGameOver)
	 Level1Scene.super.init(self)
	 onGameOver = _onGameOver
	 playdate.graphics.setColor(white)
	 
	 --Screen font
	 local font = playdate.graphics.font.new("fonts/font-rains-1x")
	 playdate.graphics.setFont(font, "normal")
end

function Level1Scene:gameOver()
	onGameOver()
end

function Level1Scene:draw()
	
	if(aPressed())then
		laser:fireBasic(playdate.getCrankPosition())
	end
	
	if(upRepeat())then
		starfield:up(1.5)
	end
	
	if(downRepeat())then
		starfield:down(1.5)
	end
	
	if(leftRepeat())then
		starfield:left(1.5)
	end
	
	if(rightRepeat())then
		starfield:right(1.5)
	end
	
	if(noDirectiontionalInput())then
		starfield:easeStraight(0.75)
	end
	
	local change = playdate.getCrankChange()
	
	if change ~= 0 then
		angle += change
		backgroundAngle += (change/3)
		backgroundAngle = normalizeAngle(backgroundAngle)	
		angle = normalizeAngle(angle)	
				
		if(change < 0 and math.abs(change) > 10)then
			ship:bankRight()
		end
		if(change > 0 and math.abs(change) > 10)then
			ship:bankLeft()
		end
		
	else
		ship:straight()
	end
	
	playdate.graphics.sprite.update()
	starBackground:draw(backgroundAngle)
	starfield:draw(angle, ship:getHitRect())
	laser:drawAll(change)
	energyBar:setEnergy(ship:getEnergy())
	energyBar:draw()
	timeBar:draw()
end