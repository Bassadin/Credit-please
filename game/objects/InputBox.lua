
-- // INPUT BOX \\ --
---------------------
local Object = require("game.objects.Object")
local InputBox = Object:create()
InputBox.__index = InputBox

--() Shortcuts ()--
-------------------
local graphics = love.graphics
local keyboard = love.keyboard

-- // Dependencies \\ --
------------------------
local commands = require("scripts.commands")


function InputBox:create(x, y, w, h)
  local self = setmetatable({}, InputBox)
  self.font = FONTS.tiny
  self.text = ""
  self.w = w or WIDTH
  self.h = h or self.font:getHeight()
  self.x = x
  self.y = y
  self.timer = 0
  self.delay = .125
  return self
end


function InputBox:setTarget(textbox)
  self.textbox = textbox
end


function InputBox:update(dt)
  self.timer = self.timer + dt
  if self.timer > self.delay then
    if keyboard.isDown("delete") or keyboard.isDown("backspace") then
      self.text = self.text:sub( 1, math.max( 0, #self.text - 1 ) )
      self.timer = 0
    end
  end
end


function InputBox:draw()
  graphics.setColor(255, 255, 255, 100)
  graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  graphics.setColor(255, 255, 255, 255)
  printFont(self.font, self.text, self.x, self.y)
end


function InputBox:keypressed(key)
  local exist
  if key == "return" then
    if self.text ~= "" then
      for k, command in pairs(commands) do 
        -- Get current command
        local currentCommand = k
        local first, last = self.text:find(currentCommand)
        -- Found matching command !
        if first then
          exist = true
          local cmd = commands[currentCommand]
          -- command got parameters
          if self.text:len() > last then
            local p1 = self.text:sub(last+2)
            if cmd.text and cmd.text ~= "" then self.textbox:pushMessage("'"..p1.."' :"..cmd.text, cmd.msgType) end
            cmd.action(self.textbox, p1)
          else -- Command don't have any parameters
            if cmd.text and cmd.text ~= "" then self.textbox:pushMessage(cmd.text, cmd.msgType) end
            if cmd.action then cmd.action(self.textbox) end
          end
        end  
      end 
      -- Does not exist!
      if not exist then self.textbox:pushMessage("'"..self.text.."' :".."Unknown command!", "warning") end
    end
    -- Delete input
    self.text = ""
  end
end


function InputBox:textinput(t)
  self.text = self.text..t
end

return InputBox
