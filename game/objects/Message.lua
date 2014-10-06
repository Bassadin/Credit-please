
-- // INPUT BOX \\ --
---------------------
local Object = require("game.objects.Object")
local MessageBox = Object:create()
MessageBox.__index = MessageBox

--() Shortcuts ()--
-------------------
local graphics = love.graphics
local keyboard = love.keyboard

-- // Dependencies \\ --
------------------------
local commands = require("scripts.commands")


function MessageBox:create(x, y, w, h)
  local self = setmetatable({}, MessageBox)
  self.font = FONTS.tiny
  self.text = ""
  self.w = w or WIDTH
  self.h = h or self.font:getHeight()
  self.x = x
  self.y = y
  self.timer = 0
  self.delay = .125
  return self
end


function MessageBox:setTarget(textbox)
  self.textbox = textbox
end


function MessageBox:update(dt)
  
end


function MessageBox:draw()
  graphics.setColor(255, 255, 255, 100)
  graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  graphics.setColor(255, 255, 255, 255)
  printFont(self.font, self.text, self.x, self.y)
end


function MessageBox:keypressed(key)
 
end


function MessageBox:textinput(t)

end

return MessageBox
