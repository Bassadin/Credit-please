
------------ Journal --------------
------------ by VADS \\--// 2014 --
-----------------------------------
local Object = require("game.objects.Object")
local Journal = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local ButtonManager = require("game.ButtonManager")
local textBox = require("game.objects.TextBox")

-- Variables
local buttons = ButtonManager:create()
local buttonClose


function Journal:setup()
  self.alpha = 255
  self.active = false
  self:setupObjects()
  
  --For debugging
  self.drawHitboxes = false
end


function Journal:setupObjects()
  -- Setup object
  self:setImage(graphics.newImage("assets/gfx/ui_journal.png"))
  self:setPosition(ORWIDTH / 2 - self:getWidth() / 2, ORHEIGHT / 2 - self:getHeight() / 2)
  
  -- Setup buttons
  buttons:clear()
  
  -- // CLOSE \\ --
  -----------------
  buttonClose = buttons:addButton("Close", "image", 0, 0, function() self:setActive(false) end)
  buttonClose:setImage(graphics.newImage("assets/gfx/ui_windowButton.png"))
  buttonClose:setParent(self)
  buttonClose:setPosition(self:getWidth() - buttonClose:getWidth(), 0)
end


function Journal:draw()
  if self.active then
    graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
    buttons:draw()
    
    -- Draw Hitboxes
    if self.drawHitboxes then 
      graphics.setColor(255, 0, 0, 255)
      for _, button in ipairs(buttons:getArray()) do
        local hitbox = button:getHitbox()
        graphics.rectangle("line", hitbox.x, hitbox.y, hitbox.w, hitbox.h)
      end
    end
    graphics.setColor(255, 255, 255)
  end
end


function Journal:update(dt)
  buttons:update(dt)
end


function Journal:mousepressed(x, y, button)  
  if self.active then
    buttons:mousepressed(x, y, button)
  end
end

return Journal
