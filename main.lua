---------------------------------------------
------------- GENERAL TEMPLATE---------------
------------ by VADS \\--// 2014 ------------
---------------------------------------------


--() Shortcuts ()--
-------------------
local graphics = love.graphics
local mouse = love.mouse


--Set Default image filter
graphics.setDefaultFilter("nearest", "nearest")
  
--// Imports \\--
-----------------
--Utils (Misc Stuff)
require("libs.Utils")

local flux = require("libs.flux")
local Fader = require("game.Fader")
local SceneManager = require("libs.SceneManager")
local Console = require("game.objects.Console")

--TSerial (Serialization)
require("libs.TSerial")

-- // Scenes \\ --
------------------
local Splash      = require("scenes.Splash")
local MainMenu    = require("scenes.MainMenu")
local GameScreen  = require("scenes.GameScreen")


-- // Constants \\ --
---------------------
--Original scale
ORSCALEX, ORSCALEY = 3, 3

--Original dimensions
ORWIDTH, ORHEIGHT = love.window.getDimensions()

-- // Globals \\ --
-------------------
WIDTH, HEIGHT = ORWIDTH, ORHEIGHT
SCALEX, SCALEY = ORSCALEX, ORSCALEY


-- // Fonts \\ --
FONTS = {
  tiny = graphics.newFont("assets/fonts/font.ttf", 16), 
  small = graphics.newFont("assets/fonts/font.ttf", 20), 
  medium = graphics.newFont("assets/fonts/font.ttf", 30), 
}


function love.load()
  -- Setup scenes
  SceneManager.newScene(Splash, "Splash")
  SceneManager.newScene(MainMenu, "MainMenu")
  SceneManager.newScene(GameScreen, "GameScreen")
  
  -- Set first scene
  SceneManager.setScene("Splash")
  
  -- Setup Console
  Console:create(64, HEIGHT - 86, WIDTH - 128, 86)
end


function love.update(dt)
  --Lurker (Realtime Code Changing)
  require('libs.lurker'):update(dt)  
  SceneManager.update(dt)
  Fader.update(dt)
  flux.update(dt)
  Console:update(dt)
end


function love.draw()
  SceneManager.draw()
  Fader.draw()
  Console:draw()
end


function love.keypressed(key)
  if not Console.active then SceneManager.keypressed(key) end
  Console:keypressed(key)
end


function love.mousepressed(x, y, button)
  SceneManager.mousepressed(x, y, button)
end


function love.textinput(t)
  Console:textinput(t)
end


function love.resize(w, h)
  WIDTH, HEIGHT = w, h
  SCALEX = (WIDTH / ORWIDTH) * ORSCALEX
  SCALEY = (HEIGHT / ORHEIGHT) * ORSCALEY
  SceneManager.resize(w, h)
end


function love.visible(v)
  SceneManager.visible(v)
end
