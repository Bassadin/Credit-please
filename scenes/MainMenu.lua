
------------ GAMESTATE MainMenu--------------
------------ by VADS \\--// 2014 ------------
---------------------------------------------
local MainMenu = {}

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local Fader = require("game.Fader")
local ButtonManager = require("game.ButtonManager")
local SceneManager = require("libs.SceneManager")


-- Variables
local buttons = ButtonManager:create()
local gameLogo = love.graphics.newImage("assets/gfx/main_logo.png")

function MainMenu:enter()
  -- Setup buttons
  buttons:clear()
  buttons:addButton("New Game", "text", ORWIDTH / 2, ORHEIGHT / 2 + 70, function() Fader.fadeTo("GameScreen") end)
  buttons:addButton("Options", "text", ORWIDTH / 2, ORHEIGHT / 2 + 100, function()end)
  local function visitHomepage() love.system.openURL("http://www.indiedb.com/company/destructivereality") end
  buttons:addButton("Developer Page", "text", ORWIDTH / 2, ORHEIGHT / 2 + 130, visitHomepage)
  buttons:addButton("Exit to Desktop", "text", ORWIDTH / 2 , ORHEIGHT / 2 + 160, function() Fader.fadeTo("exit") end)
end


function MainMenu:leave()end
function MainMenu:init() end


function MainMenu:update(dt)
  buttons:update(dt)
end


function MainMenu:draw()
  local imgw, imgh = gameLogo:getWidth() * SCALEX, gameLogo:getHeight() * SCALEY
  graphics.draw(gameLogo, WIDTH / 2 - imgw / 2, HEIGHT / 2 - imgh / 2 - 64, 0, SCALEX, SCALEY)
  buttons:draw()
end


function MainMenu:keypressed(key)
  if key == "return" then SceneManager.setScene("GameScreen") end
  if key == "escape" then SceneManager.setScene("Splash") end
end


function MainMenu:mousepressed(x, y, button)
  buttons:mousepressed(x, y, button)
end


function MainMenu:resize(w, h)
  self:enter()
end

function MainMenu:visible(v) end
function MainMenu:quit() end

return MainMenu
