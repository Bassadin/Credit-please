
local commands = {}

-- // Dependencies \\ --
------------------------
local SceneManager = require("libs.SceneManager")
local moneyManager = require("game.MoneyManager")
local TimeBox = require("game.objects.TimeBox")

local function newCommand(name, text, msgType, action)
  local command = {}
  command.text = text
  command.msgType = msgType or "system"
  command.action = action
  commands[name] = command
end

newCommand("test", "Does work!", "info")
newCommand("exit", "", "info", function() love.event.quit() end)
newCommand("restart", "", "info", function() love.load() end)
newCommand("goto", "", "info",
  function(textbox, scene)
    if scene and scene ~= "" then
      SceneManager.setScene(scene)
      textbox:pushMessage("Scene '"..scene.."' has been set.", "info")
    else
      textbox:pushMessage("Try again: goto SCENENAME", "warning")
    end
  end)
newCommand("addmoney", "", "info",
  function(textbox, money)
    money = tonumber(money)
    if money and money > 0 then
      moneyManager:addMoney(money)
      textbox:pushMessage("Added "..money.."$ to your account.", "info")
    else textbox:pushMessage("Try again: addmoney AMOUNT", "warning") end
  end)
newCommand("time", "Time toogled!", "info", function(textbox, v) if v == "toogle" then TimeBox:toggleTimeAdvancing() end end)
newCommand("vsync", "Vsync changed!", "info",
function(textbox, v)
  if not v then
    love.window.setMode(WIDTH, HEIGHT, {vsync = not vsync})
  end
  if v == "off" then love.window.setMode(WIDTH, HEIGHT, {vsync=false})
  elseif v == "on" then love.window.setMode(WIDTH, HEIGHT, {vsync=true})
  end
end)
 newCommand("fullscreen", "fullscreen toogled!", "info",
   function()
      if love.window.getFullscreen() then love.window.setFullscreen(false)
      else love.window.setFullscreen(true)
      end
   end)
 newCommand("fps", "", "", function(textbox) textbox:pushMessage("FPS: "..love.timer.getFPS(), "system")end)

-- Help command
local function helpFunction(textbox)
  local list = ""
  for k, command in pairs(commands) do
    list = list.."   "..k
  end
  textbox:pushMessage(list, "system")
end
newCommand("help", "Available commands:", "system", helpFunction)


return commands
