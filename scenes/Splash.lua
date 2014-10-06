
------------ GAMESTATE Splash--------------
------------ by VADS \\--// 2014 ----------
-------------------------------------------
local Splash = {}

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local SceneManager = require('libs.SceneManager')
local Fader = require("game.Fader")
local flux = require("libs.flux")


-- Variables
local drLogo, drBackground


function Splash:setupObjects()
   --Splash screen gameLogo
  drBackground = love.graphics.newImage("assets/gfx/drBackground.png")
  drLogo = { x = ORWIDTH / 2, y = ORHEIGHT / 2, alpha = 0, img = graphics.newImage("assets/gfx/drLogo.png"), 
  scaleX = SCALEX / 2 , scaleY = SCALEY / 2} 
end


function Splash:enter()
  self:setupObjects()
  flux.to(drLogo, 2, {alpha = 255, scaleX = SCALEX / 1.5, scaleY = SCALEY / 1.5})
    :delay(.5)
    :after(drLogo, 0.5, {alpha = 255})
    :delay(1.5)
    :oncomplete(function() Fader.fadeTo("MainMenu", 150) end)
end


function Splash:leave()
  Fader.clear()
  if flux.tweens[1] then flux.remove(1) end
end


function Splash:init()end
function Splash:update(dt)end


function Splash:draw()
  --previous Color
  local r,g,b,a = graphics.getColor()
  
  love.graphics.draw(drBackground, 0, 0, 0, SCALEX, SCALEY)
  graphics.setColor(255, 255, 255, drLogo.alpha)
  
  graphics.draw(drLogo.img, drLogo.x * (SCALEX / ORSCALEX), drLogo.y * (SCALEY / ORSCALEY), 0, drLogo.scaleX, drLogo.scaleY, 
  drLogo.img:getWidth() / 2, drLogo.img:getHeight() / 2)
  
  --Reapply previous color
  graphics.setColor(r,g,b,a)
end


function Splash:keypressed(key)
  if key == "r" then
    SceneManager.setScene("Splash")
    Fader.clear()
    if flux.tweens[1] then flux.remove(1) end
  end
  if key == " " then
    SceneManager.setScene("MainMenu")
    Fader.clear()
    if flux.tweens[1] then flux.remove(1) end
  end
  if key == "escape" then love.event.quit() end
end


function Splash:mousepressed(x, y, button)
  SceneManager.setScene("MainMenu")
  Fader.clear()
  if flux.tweens[1] then flux.remove(1) end
end


function Splash:resize(w, h)
  self:setupObjects()
end


function Splash:visible(v)end

return Splash
