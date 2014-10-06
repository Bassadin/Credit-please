
------------ MoneyManager ---------
------------ by VADS \\--// 2014 --
-----------------------------------
local Object = require("game.objects.Object")
local MoneyManager = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

function MoneyManager:setup()
  self.money = 10000
  self:setupObjects()
end


function MoneyManager:setupObjects()
  -- Setup object
  self:setImage(graphics.newImage("assets/gfx/ui_money.png"))
  self:setPosition(ORWIDTH - self:getWidth() - 28, 4)
end


function MoneyManager:draw()
  --Draws the money value on the screen
  graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
  printFontCentered(FONTS.small, "Money:", self.x + self.w / 2, self.y + self.h / 2 - 26, WIDTH)
  printFontCentered(FONTS.medium, self.money.."$", self.x + self.w / 2, self.y + self.h / 2 - 8, WIDTH)
end


function MoneyManager:addMoney(amount)
  if not amount then assert(amount, "No amount set!") end
  self.money = self.money + amount
end


return MoneyManager
