
-- // PHONE \\ --
-----------------
local Object = require("game.objects.Object")
local Phone = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local Button = require("game.objects.Button")
local Console = require("game.objects.Console")


-- Variables
local phoneRinging
-- Width and height
local imgw, imgh = 10, 8

function Phone:setup()
  self.animRinging = newAnimation(graphics.newImage("assets/gfx/phone_ringing.png"), imgw, imgh, 0.16, 0)
  self.isRinging = false
  self.timer = 0
  self.ringTime = math.random(10, 30)
  self.ringTimer = 0
  self.hover = false
  self.active = true
  self.actionTime = math.random(5, 30)
  self.textbox = Console.textbox
  self:setupObjects()
end


function Phone:setupObjects()
  -- Setup phone object
  self:setPosition(140, 380)  
  self:setDimensions(imgw, imgh)
  -- Setup button (hitbox only)
  self.button = Button:create("Phone", "hitbox", self.x, self.y, function()
      self.timer = 0
      self.actionTime = math.random(5, 30)
      self.ringTime = math.random(10, 20)
      self.ringTimer = 0
      self.isRinging = false
      self.animRinging:seek(1)
      end)
  self.button:setDimensions(self.w / SCALEX, self.h / SCALEY)
  self.button:setHitboxVisible(false)
end


function Phone:update(dt)
  if self.active then
    self.timer = self.timer + dt
    if self.timer > self.actionTime then
      self.isRinging = true
      self.ringTimer = self.ringTimer + dt
      if self.ringTimer > self.ringTime then
        self.button.action()
      end
    end
    -- Update Button
    self.button:update(dt)
    if self.isRinging then
      -- Update Animation
      self.animRinging:update(dt)
    end
  end
end


function Phone:draw()
  if self.button.selected then
    graphics.setColor(255, 255, 255)
  else
    graphics.setColor(185, 185, 185)
  end
  self.animRinging:draw(self.x, self.y, 0, SCALEX, SCALEY)
  self.button:draw()
  graphics.setColor(255, 255, 255)
end


function Phone:mousepressed(x, y, button)
  self.button:mousepressed(x, y, button)
end

return Phone
