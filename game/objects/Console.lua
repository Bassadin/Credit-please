

-- // DEBUG COSOLE \\ --
------------------------
local Object = require("game.objects.Object")
local Console = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local InputBox = require("game.objects.InputBox")
local TextBox = require("game.objects.TextBox")

function Console:create(x, y, w, h)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.active = false
  self.textbox = TextBox:create(self.x + 2, self.y + 2, self.w - 4, self.h - self.h / 3)
  self.textbox:pushMessage("'Credits, Please' Console", "")
  self.textbox:pushMessage("------------------", "")
  self.inputbox = InputBox:create(self.x + 2, self.y + self.h - 24, self.w - 4)
  self.inputbox:setTarget(self.textbox)
end


function Console:update(dt)
  if self.active then
    self.inputbox:update(dt)
  end
end


function Console:draw()
  if self.active then
    graphics.setColor(15, 5, 5, 220)
    graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    graphics.setColor(255, 255, 255, 255)
    self.inputbox:draw()
    self.textbox:draw()
  end
end


function Console:keypressed(key)
  if key == "f1" then
    self.active = not self.active
  end
  if self.active then
    if key == "escape" then self.active = false end
    self.inputbox:keypressed(key)
  end
end


function Console:textinput(t)
  if self.active then self.inputbox:textinput(t) end
end

return Console
