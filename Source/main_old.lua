import "CoreLibs/sprites"
import 'Coracle/coracle'
import 'Coracle/Particles/starfield'
import 'Coracle/Particles/starbackground'

playdate.display.setInverted(true)

local starfield = Starfield(50, 4, 12)
local starBackground = StarBackground(100, 1)

local ship_default = playdate.graphics.image.new("images/ship_default")
local ship_left = playdate.graphics.image.new("images/ship_bank_left")
local ship_right = playdate.graphics.image.new("images/ship_bank_right")
local shipSprite = playdate.graphics.sprite.new(ship_default)
shipSprite:moveTo(200, 200)
shipSprite:add()

playdate.graphics.sprite.setBackgroundDrawingCallback(
		function( x, y, width, height )
			
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

function playdate.update()	
	background()	
	
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
				
		if(change > 0 and math.abs(change) > 10)then
			--right
			shipSprite:setImage(ship_right)
			
		end
		if(change < 0 and math.abs(change) > 10)then
			--left
			shipSprite:setImage(ship_left)
			
		end
		
	else
		shipSprite:setImage(ship_default)
	end
	
	playdate.graphics.sprite.update()
	starBackground:draw(backgroundAngle)
	starfield:draw(angle)
	playdate.graphics.setColor(playdate.graphics.kColorBlack)
	
end