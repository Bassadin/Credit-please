
------------ Toolbar --------------
------------ by VADS \\--// 2014 --
-----------------------------------
local Object = require("game.objects.Object")
local Toolbar = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local flux = require("libs.flux")
local ButtonManager = require("game.ButtonManager")
local Journal = require("game.Journal")
local textBox = require("game.objects.TextBox")


-- Variables
local buttons = ButtonManager:create()
local buttonFinancial, buttonJournal, buttonClose
local icons = graphics.newImage("assets/gfx/ui_toolIcons.png")


local function moveToolbar()
  local self = Toolbar
  if self.state ~= ("movingin" or "movingout") then
    if self.state == "in" then
      self.state = "movingout"   
      --move the Toolbar to the right
      flux.to(self, 0.5, { x = - self.image:getWidth() * SCALEX + 2 * SCALEX }):oncomplete(function() self.state = "out" end)   
    elseif self.state == "out" then  
      self.state = "movingin" 
      --Move the Toolbar to the left
      flux.to(self, 0.5, { x = 0 }):oncomplete(function() self.state = "in" end)
    end
  end
end


function Toolbar:setup()
  self.state = "in"
  self:setupObjects()
  self.drawHitboxes = false
end


function Toolbar:setupObjects()
  -- Setup object
  self:setImage(graphics.newImage("assets/gfx/ui_tools.png"))
  self:setPosition(0, 120)
  
  -- Setup buttons
  buttons:clear()
  
  -- // CLOSE \\ --
  -----------------
  buttonClose = buttons:addButton("Close", "image", 0, 0, moveToolbar)
  buttonClose:setImage(graphics.newImage("assets/gfx/ui_toolsbutton.png"))
  buttonClose:setParent(Toolbar)
  buttonClose:setPosition(self:getWidth() - 2 , 10)
  
  -- // FINANCIAL \\ --
  ---------------------
  local w, h = 12, 6
  buttonFinancial = buttons:addButton("Financial", "image", 1, 15, function() Journal:setActive(not Journal.active) end)
  buttonFinancial:setDimensions(w, h)
  buttonFinancial:setImage(graphics.newQuad(1, 1, w, h, 112, 8), icons)
  buttonFinancial:setParent(Toolbar)
  
  -- // JOURNAL \\ --
  -------------------
  w, h = 8, 8 -- local
  buttonJournal = buttons:addButton("Journal", "image", 7, 48, function() Journal:setActive(not Journal.active) end)
  buttonJournal:setDimensions(w, h)
  buttonJournal:setImage(graphics.newQuad(17, 0, w, h, 112, 8), icons)
  buttonJournal:setParent(Toolbar)
end


function Toolbar:update(dt)
  buttons:update(dt)
end


function Toolbar:draw()
  -- Draw Toolbar Image
  graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
  
  -- Draw Buttons
  buttons:draw()
  
  -- Draw Hitboxes
  if self.drawHitboxes then 
    for _, button in ipairs(buttons:getArray()) do button:setHitboxVisible(true) end
  end
  
  -- Reset Color
  graphics.setColor(255, 255, 255, 255)
end


function Toolbar:mousepressed(x, y, button)
  buttons:mousepressed(x, y, button)
end

return Toolbar
