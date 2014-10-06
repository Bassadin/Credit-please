
-- // TEXT BOX \\ --
--------------------
local Object = require("game.objects.Object")
local TextBox = Object:create()
TextBox.__index = TextBox

--() Shortcuts ()--
-------------------
local graphics = love.graphics
local types = {
    ["system"] = {name = "System: ", color = {255, 255, 255}},
    ["warning"] = {name = "Warning: ", color = {180, 0, 0}},
    ["info"] = {name = "Info: ", color = {0, 180, 0}},
    [""] = {name = "", color = {255, 255, 255}},
  }

function TextBox:pushMessage(text, msgType)
  local newMessage = {}
  newMessage.x = self.x
  newMessage.y = self.y + self.h - self.font:getHeight()
  newMessage.msgType = types[msgType]
  newMessage.text = types[msgType].name..text
  newMessage.color = types[msgType].color or {255, 255, 255}
  
  -- Update positions
  for _, message in ipairs(self.textArray) do
    message.y = message.y - self.font:getHeight()
  end
  
  -- Insert message
  table.insert(self.textArray, newMessage)
  
  -- Delete oldest message
  if #self.textArray > self.h / self.font:getHeight() then
    table.remove(self.textArray, 1)
  end
end


function TextBox:create(x, y, w, h)
  local self = setmetatable({}, TextBox)
  self.font = FONTS.tiny
  self.textArray = {}
  self.w = w or WIDTH
  self.h = h or self.font:getHeight() * 2
  self.x = x
  self.y = y
  return self
end


function TextBox:draw()
  graphics.setColor(255, 255, 255, 100)
  graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  for k, message in ipairs(self.textArray) do
    local r, g, b = message.color[1], message.color[2], message.color[3]
    graphics.setColor(r, g, b, 255)
    printFont(self.font, message.text, message.x, message.y)
  end
  graphics.setColor(255, 255, 255, 255)
end

return TextBox
