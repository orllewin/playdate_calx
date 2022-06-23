--[[
    A 2D star background that rotates
--]] 

import 'Coracle/coracle'
import 'Coracle/vector'

class('BackgroundStar').extends()
class('StarBackground').extends()

local atan2 <const> = math.atan2
local cos <const> = math.cos
local deg <const> = math.deg
local rad <const> = math.rad
local random <const> = math.random
local sin <const> = math.sin

local cX = width/2
local cY = height/2

function BackgroundStar:init(x, y)
   BackgroundStar.super.init(self)
   self.x = x
   self.y = y
end

function StarBackground:init(starCount, starSize)
   StarBackground.super.init(self)
   self.stars = {}
   self.starSize = starSize
   for i = 1, starCount do
     local backgroundStar = BackgroundStar(width/2 + math.random(-300, 300), height/2 + math.random(-300, 300))
     table.insert(self.stars, backgroundStar)
    end
end

function StarBackground:draw(crankDegrees)
  for i = 1, #self.stars do
    local star = self.stars[i]
        
    --distance origin to star
    local r = distance(star.x, star.y, cX, cY)
    
    local currentRadians = atan2 ( cY - star.y, star.x - cX) 
    local currentDegrees = deg(currentRadians)
    local targetDegrees = currentDegrees + (crankDegrees)
    
    local targetRadians = rad(targetDegrees)
    local xx = sin(targetRadians)
    local yy = -1 * cos(targetRadians)
    
    xx = (r * xx) + cX
    yy = (r * yy) + cY
    
    if(self.starSize > 0)then
      circle(xx, yy, self.starSize)
    else
      point(xx, yy)
    end
  end
end