

-- // Base Object Class \\ --
-----------------------------

local Object = {}
Object.__index = Object

-- Variables
Object.removed = false


local function boxCollision(a, b)
  return a.x + a.w > b.x and a.x < b.x + b.w and
  a.y + a.h > b.y and a.y < b.y + b.h
end


function Object:create()
  local self = setmetatable({}, Object)
  self.removed = false
  return self
end


function Object:destroy()
  self.removed = true
end

-- // HITBOXES \\ --
--------------------
function Object:setHitbox(x, y, w, h)
  self.hitbox = {x = x, y = y, w = w, h = h}
end


function Object:getHitbox()
  return {x = self.hitbox.x, y = self.hitbox.y, w = self.hitbox.w, h = self.hitbox.h}
end

-- // COLLISION \\ --
---------------------
function Object:boxCollision(Object)
  if not self.hitbox then assert("No hitbox set!") end
  if boxCollision(self.hitbox, Object) then return true end
end

-- // FONT \\ --
----------------
function Object:setFont(font)
  self.font = font
  self.w = self.font:getWidth(self.name)
  self.h = self.font:getHeight()
end

-- // POSITION \\ --
--------------------
function Object:setPosition(x, y)
  if x then
    self.startx = x * (SCALEX / ORSCALEX)
    self.x = self.startx
  end
  if y then
    self.starty = y * (SCALEY / ORSCALEY)
    self.y = self.starty
  end
  self:setHitbox(self.x, self.y, self.w, self.h)
end


function Object:getPosition()
  return self.x, self.y
end

-- // IMAGE / QUAD \\ --
------------------------
function Object:setImage(image, quadImage)
  self.image = image
  if quadImage then
    self.quadImage = quadImage
  else
    self.w = self.image:getWidth() * SCALEX 
    self.h = self.image:getHeight() * SCALEY
  end
  self:setHitbox(self.x, self.y, self.w, self.h)
end

-- // WIDTH / HEIGHT \\ --
--------------------------
function Object:setDimensions(w, h)
  self.w, self.h = w * SCALEX, h * SCALEY
  self:setHitbox(self.x, self.y, self.w, self.h)
end


function Object:getWidth()
  return self.w / (SCALEX / ORSCALEX)
end


function Object:getHeight()
  return self.h / (SCALEY / ORSCALEY)
end

-- // OTHER \\ --
-----------------
function Object:setActive(v)
  self.active = v
end


function Object:setParent(parent)
  self.parent = parent
end

return Object
