
-------------------------
-- // ButtonManager \\ --
-------------------------

local ButtonManager = {}
ButtonManager.__index = ButtonManager


-- // Dependencies \\ --
------------------------
local Button = require("game.objects.Button")


function ButtonManager:create()
  local self = setmetatable({}, ButtonManager)
  self.buttons = {}
  return self
end


function ButtonManager:getArray()
  return self.buttons
end


function ButtonManager:addButton(name, mode, x, y, action)
  local button = Button:create(name, mode, x, y, action)
  table.insert(self.buttons, button)
  return button
end


function ButtonManager:clear()
  self.buttons = {}
end


function ButtonManager:update(dt)
  for k, v in ipairs(self.buttons) do
    v:update(dt)
  end
end


function ButtonManager:draw()
  for k, v in ipairs(self.buttons) do
    v:draw()
  end
end


function ButtonManager:mousepressed(x, y, button)
  for k, v in ipairs(self.buttons) do
    if button == "l" and v.selected then v.action() end
  end
end

return ButtonManager
