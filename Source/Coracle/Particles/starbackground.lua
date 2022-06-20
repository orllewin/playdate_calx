--[[
    A 2D star background that rotates
--]] 

import 'Coracle/coracle'
import 'Coracle/vector'

class('BackgroundStar').extends()
class('StarBackground').extends()

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
    
    local currentRadians = math.atan2 ( cY - star.y, star.x - cX) 
    local currentDegrees = math.deg(currentRadians)
    local targetDegrees = currentDegrees + (crankDegrees)
    
    local targetRadians = math.rad(targetDegrees)
    local xx = math.sin(targetRadians)
    local yy = -1 * math.cos(targetRadians)
    
    xx = (r * xx) + cX
    yy = (r * yy) + cY
    
    if(self.starSize > 0)then
      circle(xx, yy, self.starSize)
    else
      point(xx, yy)
    end
    
  
  end
end