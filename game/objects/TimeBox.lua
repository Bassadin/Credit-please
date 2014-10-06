

-- // TimeBox \\ --
-------------------
local Object = require("game.objects.Object")
local TimeBox = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics


-- // Dependencies \\ --
------------------------
local ButtonManager = require("game.ButtonManager")
local moneyManager = require("game.MoneyManager")


-- // Variables \\ --
---------------------
local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
local monthNames = {"January", "February", "March", "April", "May", "June", "July", "August",
                    "September", "October", "November", "December"}
--Time advancing speed
local speed = { stop = 0, slow = .05, medium = .2, fast = 5 }

-- Create Button Handler
local buttons = ButtonManager:create()
local button1, button2, button3


local function setSelected(currentButton)
  for i, button in ipairs(buttons:getArray()) do
    button:setColor({150, 150, 150}, {255, 255, 255})
    if currentButton == button then
      button:setColor({50, 200, 50}, {50, 255, 50})
    end
  end
end


function TimeBox:setup()
  self.day = 27
  self.month = 4
  self.year = 1960
  self.timer = 0
  self.speed = .1
  self.money = 10000
  self.font = FONTS.medium
  self:setupObjects()
end


function TimeBox:setupObjects()
  -- Setup object
  self:setImage(graphics.newImage("assets/gfx/ui_box.png"))
  self:setPosition(304, 7)
  
  -- Setup Buttons
  buttons:clear()

  -- // Stop \\ --
  ------------------------
  button0 = buttons:addButton("Stop", "image", 0, 0, function()
      self.speed = speed.stop
      setSelected(button0)
      button0:setColor({200, 50, 50}, {255, 100, 100})
      end)
  button0:setImage(graphics.newImage("assets/gfx/ui_timeButton0.png"))
  button0:setParent(self)
  button0:setPosition(self:getWidth() / 2 - 42 - button0:getWidth() / 2, 38)
  
  -- // Normal Speed \\ --
  ------------------------
  button1 = buttons:addButton("Normal Time", "image", 0, 0, function()
      self.speed = speed.slow
      setSelected(button1)
      end)
  button1:setImage(graphics.newImage("assets/gfx/ui_timeButton1.png"))
  button1:setParent(self)
  button1:setPosition(self:getWidth() / 2 - 19 - button1:getWidth() / 2, 35)
  setSelected(button1)
  
  -- // Double Speed \\ --
  ------------------------
  button2 = buttons:addButton("Double Time", "image", 0, 0, function()
      self.speed = speed.medium
      setSelected(button2)
      end)
  button2:setImage(graphics.newImage("assets/gfx/ui_timeButton2.png"))
  button2:setParent(self)
  button2:setPosition(self:getWidth() / 2 - 6, 35)
  
  -- // Triple Speed \\ --
  ------------------------
  button3 = buttons:addButton("Triple Time", "image", 0, 0, function()
      self.speed = speed.fast
      setSelected(button3)
      end)
  button3:setImage(graphics.newImage("assets/gfx/ui_timeButton3.png"))
  button3:setParent(self)
  button3:setPosition(self:getWidth() / 2 + 36 - button3:getWidth() / 2, 35)
end


function TimeBox:update(dt)
  -- Update buttons
  buttons:update(dt)
  
  --Updating/increasing time
  if self.speed > 0 then self.timer = self.timer + dt end
  if self.timer >= 1 / self.speed then
    self:nextDay()
    self.timer = 0
  end
end


function TimeBox:draw()
  --Draws the money value on the screen
  graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
  printFontCentered(self.font, self:getDateString(), self.x + self.w / 2, self.y + self.h / 2 - 28, WIDTH)
  
  -- Set button color if selected
  -- Draw Buttons
  buttons:draw()
end


function TimeBox:mousepressed(x, y, button)
  buttons:mousepressed(x, y, button)
end


function TimeBox:getDateString()
  return self.day..". "..monthNames[self.month].." "..self.year
end


function TimeBox:nextDay()
  --Counting up day/month
  if self.day == monthDays[self.month] then
    self.day = 1
    self.month = self.month + 1
    --Calls both the day and month action function
    self:actionOnDay()
    self:actionOnMonth()
  else
    self.day = self.day + 1
    --Calls the day action function
    self:actionOnDay()
  end
  
  --Counting up year
  if self.month > 12 then
    self.year = self.year + 1
    self.month = 1
    
    --Calls the action on year function
    self:actionOnYear()
    
    if self.year % 4 == 0 then
      if self.year % 100 == 0 then
        if self.year % 400 == 0 then
          monthDays[2] = 29 
        else
          monthDays[2] = 28
        end
      else
        monthDays[2] = 29
      end
    else
      monthDays[2] = 28
    end
  end
end


function TimeBox:addDays(days)
  for i = 0, days - 1, 1 do
    self:nextDay()
  end
end


function TimeBox:actionOnDay()
  
end


function TimeBox:actionOnMonth()
  moneyManager.money = moneyManager.money + 1000
  self:setTimeState("stop")
end


function TimeBox:actionOnYear()
end


--Todo - Funktioniert so nicht, hält nur die Zeit an
function TimeBox:toggleTimeAdvancing()
  button0.action()
end

function TimeBox:setTimeState(state)
  if state == "stop" then button0.action() end
  if state == "slow" then button1.action() end
  if state == "medium" then button2.action() end
  if state == "fast" then button3.action() end
end


function TimeBox:getCurrentMonthName()
  return monthNames[self.month]
end


function TimeBox:isTimeAdvancing()
  return self.speed > 0
end

return TimeBox
