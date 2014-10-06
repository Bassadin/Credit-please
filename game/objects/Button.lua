
-- // Button Class \\ --
------------------------
local Object = require("game.objects.Object")
local Button = Object:create()
Button.__index = Button

--() Shortcuts ()--
-------------------
local graphics = love.graphics


function Button:create(name, mode, x, y, action)
  local self = setmetatable({}, Button)
  self.name = name
  self.startx = x * (SCALEX / ORSCALEX)
  self.starty = y * (SCALEY / ORSCALEY)
  self.x = x
  self.y = y
  self.mode = mode
  self.active = true
  self.selected = false
  self.rotation = 0
  self.color = {150, 150, 150}
  self.selectedColor = {255, 255, 255}
  self.isHitboxVisible = false
  self.action = action or nil
  -- Setup text button
  if mode == "text" then 
    self:setFont(FONTS.medium)
    self:setPosition(self.x - (self:getWidth() / 2), self.y - (self.h / 2 / self:getHeight()))
    self:setHitbox(self.x, self.y + 8, self.w, self.h - 14)
  end
  return self
end


function Button:setSelected(boolean)
  self.selected = boolean
end


function Button:setMode(mode)
  self.mode = mode
end


function Button:setColor(normal, selected)
  self.color = normal
  self.selectedColor = selected
end


function Button:setHitboxVisible(v)
  self.isHitboxVisible = v
end


function Button:update(dt)
  local mouse = {x = love.mouse.getX(), y = love.mouse.getY(), w = 1, h = 1}
  if self.active and self.hitbox then
    self.selected = false
    if self:boxCollision(mouse) then
      self.selected = true
    end
  end
  -- Update position
  if self.parent then
    self.x = self.startx + self.parent.x
    self.y = self.starty + self.parent.y
    self:setHitbox(self.x, self.y, self.w , self.h)
  end
end


function Button:draw()
  -- Set Color
  local r, g, b = unpack(self.selectedColor)
  if self.selected then
    graphics.setColor(r, g, b, 255)
  else
    r, g, b = unpack(self.color)
    graphics.setColor(r, g, b, 255)
  end
  
  -- TEXT BUTTON --
  ----------------- 
  if self.mode == "text" then
    printFont(self.font, self.name, self.x, self.y)
  end
    
  -- IMAGE BUTTON --
  ------------------
  if self.mode == "image" then
    if not self.image then assert(self.image, "No image set!") end
    if self.quadImage then graphics.draw(self.quadImage, self.image, self.x, self.y, self.rotation, SCALEX, SCALEY)
    else graphics.draw(self.image, self.x, self.y, self.rotation, SCALEX, SCALEY) end
  end
  
  if self.isHitboxVisible then
    local hitbox = self.hitbox
    graphics.setColor(255, 0, 0, 255)
    if hitbox then graphics.rectangle("line", hitbox.x, hitbox.y, hitbox.w, hitbox.h) end
  end

  graphics.setColor(255, 255, 255, 255)
end


function Button:mousepressed(x, y, button)
  if button == "l" and self.selected then self.action() end
end

return Button
