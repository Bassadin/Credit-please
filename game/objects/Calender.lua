
-- // Calender \\ --
--------------------
local Object = require("game.objects.Object")
local Calender = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local ButtonManager = require("game.ButtonManager")
local Console = require("game.objects.Console")
local flux = require("libs.flux")

-- Variables
local buttons = ButtonManager:create()


local function moveCalender()
  local self = Calender
  if self.state ~= ("movingin" or "movingout") then
    if self.state == "in" then
      self.state = "movingout"   
      -- Move down
      flux.to(self, 1, { y = self.starty + self:getHeight()}):oncomplete(function() self.state = "out" end)   
    elseif self.state == "out" then  
      self.state = "movingin" 
      -- Move up
      flux.to(self, 1, { y = self.starty}):oncomplete(function() self.state = "in" end)
    end
  end
end

function Calender:setup()
  self.state = "in"
  self.timer = 0
  self.textbox = Console.textbox
  self:setupObjects()
end


function Calender:setupObjects()
  self:setImage(graphics.newImage("assets/gfx/ui_calender.png"))
  self.startx = 505
  self.starty = 90
  self:setPosition(self.startx, self.starty - self:getHeight())
  -- Setup buttons
  buttons:clear()
  
  -- // Calender Object \\ --
  ---------------------------
  local top = buttons:addButton("Calender", "image", 0, 0, function() moveCalender() end)
  top:setPosition(505, 70)
  top:setColor({235, 235, 235}, {255, 255, 255})
  top:setImage(graphics.newImage("assets/gfx/ui_calenderTop.png"))
end


function Calender:update(dt)
  buttons:update(dt)
end


function Calender:draw()
  graphics.setScissor(self.startx, self.starty + self:getHeight(), self:getWidth(), self:getHeight())
  if self.state ~= "in" then
    graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
  end
  graphics.setScissor()
  buttons:draw()
end


function Calender:mousepressed(x, y, button)
  buttons:mousepressed(x, y, button)
end

return Calender
