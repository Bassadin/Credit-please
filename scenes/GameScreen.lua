
------------ GAMESTATE GameScreen------------
------------ by VADS \\--// 2014 ------------
---------------------------------------------
local GameScreen = {}

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
-- Animation library
require("libs.AnAL")
local SceneManager = require("libs.SceneManager")

--Requires
local moneyManager = require("game.MoneyManager")
local Toolbar = require("game.Toolbar")
local Journal = require("game.Journal")
local Phone = require("game.objects.Phone")
local TimeBox = require("game.objects.TimeBox")
local Calender = require("game.objects.Calender")
local Console = require("game.objects.Console")
local Window = require("game.objects.Window")

--Sprites
local background = graphics.newImage("assets/gfx/game_room.png")
local infobar = graphics.newImage("assets/gfx/ui_bar.png") 
local speechbox = graphics.newImage("assets/gfx/ui_speechbubble.png")

--Animation sprites
local advisorImg = graphics.newImage("assets/gfx/advisor_anim.png")
--Animations
local advisor = newAnimation(advisorImg, 16, 16, 0.3, 0)



function GameScreen:enter()
  --Loading stuff
  self.textbox = Console.textbox
  Toolbar:setup()
  Journal:setup()
  moneyManager:setup()
  Phone:setup()
  TimeBox:setup()
  Calender:setup()
  Window:setup()
  self.textbox:pushMessage("Game started!", "info")
end

function GameScreen:leave()end
function GameScreen:init()end

function GameScreen:update(dt)
  --Animation updates
  advisor:update(dt)
  
  --Toolbar/Journal update
  Toolbar:update(dt)
  Journal:update(dt)
  
  -- Objects
  Phone:update(dt)
  TimeBox:update(dt)
  Calender:update(dt)
  Window:update(dt)
end


function GameScreen:draw()
  -- Draw stuff
  graphics.draw(background, 0, 0, 0, SCALEX, SCALEY)
  graphics.draw(infobar, WIDTH - infobar:getWidth() * SCALEX - 8 * (SCALEX / ORSCALEX), 10 * (SCALEY / ORSCALEY), 0, SCALEX, SCALEY)
  
  -- Objects
  Window:draw()
  Calender:draw()
  moneyManager:draw()
  TimeBox:draw()
  Toolbar:draw()
  Journal:draw()
  Phone:draw()


  
  --Speechbubble
  graphics.draw(speechbox, 16 * SCALEX, 5 * SCALEY, 0 ,SCALEX, SCALEY)
  printFont(FONTS.tiny, "Hey! What's up?", 130, 32)
  
  --Animations
  advisor:draw(2.5 * SCALEX, 5 * SCALEY, 0, SCALEX, SCALEY)
end


function GameScreen:keypressed(key)
  if key == "escape" then SceneManager.setScene("MainMenu") end
end


function GameScreen:mousepressed(x, y, button)
  Toolbar:mousepressed(x, y, button)
  Journal:mousepressed(x, y, button)
  Phone:mousepressed(x, y, button)
  TimeBox:mousepressed(x, y, button)
  Calender:mousepressed(x, y, button)
end

function GameScreen:resize(w, h)
  Toolbar:setupObjects()
  Journal:setupObjects()
  moneyManager:setupObjects()
  Phone:setupObjects()
  TimeBox:setupObjects()
  Calender:setupObjects()
end

function GameScreen:visible(v)end

return GameScreen
