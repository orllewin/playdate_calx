--[[
		Coracle
--]]

import 'CoreLibs/graphics'
import 'CoreLibs/object'
import 'Coracle/vector'

class('Drawing').extends()
class('Game').extends()

local graphics <const> = playdate.graphics

DrawingMode = {Stroke = "0", Fill = "1", FillAndStroke = "2"}

TAU = 6.28318

white = playdate.graphics.kColorWhite
black = playdate.graphics.kColorBlack

mode = DrawingMode.FillAndStroke
alpha = 1.0

width = 400
height = 240

-- Center of the screen
C = Vector(200, 120)

-- clears the screen, use with white or black: background(black)
function background(color)
	graphics.clear(color)
end

function noStroke()
	mode = DrawingMode.Fill
end

function noFill()
	mode = DrawingMode.Stroke
	graphics.setDitherPattern(0.0, playdate.graphics.image.kDitherTypeScreen)
end


function setTextWhite()
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)
end

function setTextBlack()
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillBlack)
end

function setBlack()
	playdate.graphics.setColor(black)
end

function setWhite()
	playdate.graphics.setColor(white)
end

function resetDrawMode()
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)
end

function stroke()
	if(mode == DrawingMode.Fill) 
	then
	mode = DrawingMode.FillAndStroke
	end
end

function fill()
	if(mode == DrawingMode.Stroke)
	then
	mode = DrawingMode.FillAndStroke
	end
end

-- alpha: 0.0 to 1.0
function fill(alpha)
	alpha = alpha
	graphics.setDitherPattern(1.0 - alpha, playdate.graphics.image.kDitherTypeBayer8x8)
	if(mode == DrawingMode.Stroke) 
	then
	mode = DrawingMode.FillAndStroke
	end
end

function resetFill()
	graphics.setDitherPattern(nill)
end

function text(text, x, y)
	graphics.drawText(text, x, y)
end
 
function circle(x, y, r)
	if(mode == DrawingMode.FillAndStroke)
	then
	graphics.fillCircleAtPoint(x, y, r)
	graphics.drawCircleAtPoint(x, y, r)
	elseif(mode == DrawingMode.Fill)
	then
	graphics.fillCircleAtPoint(x, y, r)
	else
	graphics.drawCircleAtPoint(x, y, r)
	end
end

function square(x, y, d)
	if(mode == DrawingMode.FillAndStroke)
	then
		graphics.fillRect(x, y, d, d)
		graphics.drawRect(x, y, d, d)
	elseif(mode == DrawingMode.Fill)
	then
		graphics.fillRect(x, y, d, d)
	else
		graphics.drawRect(x, y, d, d)
	end
end

function line(x1, y1, x2, y2)
	graphics.drawLine(x1, y1, x2, y2)
end

function point(x, y)
	graphics.drawPixel(x, y)
end

function cross(x, y, size)
	line(x, y - size, x, y + size)
	line(x - size, y, x + size, y)
end

function clearLog()
	playdate.clearConsole()
end

--[[
		Input
		Pressed state is if a button was pressed, Repeat is if button is held down.
		Use Pressed for most things, Repeat for controlling movement
--]]
function aPressed()
	return playdate.buttonJustPressed(playdate.kButtonA)
end

function bPressed()
	return playdate.buttonJustPressed(playdate.kButtonB)
end

function upPressed()
	return playdate.buttonJustPressed(playdate.kButtonUp)
end

function downPressed()
	return playdate.buttonJustPressed(playdate.kButtonDown)
end

function leftPressed()
	return playdate.buttonJustPressed(playdate.kButtonLeft)
end

function rightPressed()
	return playdate.buttonJustPressed(playdate.kButtonRight)
end

function upRepeat()
	return playdate.buttonIsPressed(playdate.kButtonUp)
end

function downRepeat()
	return playdate.buttonIsPressed(playdate.kButtonDown)
end

function leftRepeat()
	return playdate.buttonIsPressed(playdate.kButtonLeft)
end

function rightRepeat()
	return playdate.buttonIsPressed(playdate.kButtonRight)
end

function noDirectiontionalInput()
	return leftRepeat() == false and rightRepeat() == false and upRepeat() == false and downRepeat() == false
end

function crankUp()
	local change, acceleratedChange = playdate.getCrankChange()
	if(change > 0.0)
	then
		return true
	else
		return false
	end
end

function crankDown()
	local change, acceleratedChange = playdate.getCrankChange()
	if(change < 0.0)
	then
		return true
	else
		return false
	end
end

-- Accelerometer
function accelerometerStart()
	playdate.startAccelerometer()
end

function accelerometerRead()
	return playdate.readAccelerometer()
end

-- Orientation
function isLandscape()
	local x, y = accelerometerRead()
	if(math.abs(y) < math.abs(x))then
		return false
	else
		return true
	end
end

function isPortrait()
	local x, y = accelerometerRead()
	if(math.abs(y) < math.abs(x))then
		return true
	else
		return false
	end
end

function isUpsideDown()
	if(isLandscape())then
		local x, y = accelerometerRead()
		return y < 0
	else
		return false
	end
end

-- Audio
function sampleLoad(path)
	return playdate.sound.sampleplayer.new(path)
end

-- Noise
function perlinNoise(x, y)
	return playdate.graphics.perlin(x, y, 1)
end

-- Utility and Maths
function ring(a, min, max)
	if min > max then
		min, max = max, min
	end
	return min + (a-min) % (max-min)
end

function distance(x1, y1, x2, y2)
	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt(dx * dx + dy * dy)
end

function fastDistance(x1, y1, x2, y2)
  local dx = x1 - x2
  local dy = y1 - y2
	local x = dx * dx + dy * dy
	if(x < 1)then
		return fastSqrt(dx * dx + dy * dy, 6)
	else
		return fastSqrt(dx * dx + dy * dy)
	end
end

-- Safe for larger distances > 1
function fastSqrt(x)
  local s=((x/2) + x / (x/2)) / 2
  for i = 1, 3 do
      s = (s + x/s) / 2
  end
  return s
end

-- precision: 2 to n, higher is more accurate
-- use this method when distances are very small with precision of 5 or 6
function fastSqrt2(x, precision)
	local s=((x/2) + x / (x/2)) / 2
	for i = 1, precision do
			s = (s + x/s) / 2
	end
	return s
end