
-------------------------
-- // ObjectHandler \\ --
-------------------------
local ObjectHandler = {}
ObjectHandler.__index = ObjectHandler

--[[
Copyright (c) 2013 Lars Lönneker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--]]

------------------------
-- // Declarations \\ --
------------------------


function ObjectHandler.new(o)
  local self = o or {}
  self.name = self.name or "Handler"
  self.container = {}
  setmetatable(self, ObjectHandler)
  return self
end


function ObjectHandler:add(v)
	table.insert(self.container, v)
end


function ObjectHandler:destroy()
  self.container = {}
end


function ObjectHandler:getAmount(name)
  local amount = 0
	for k = 1, #self.container do
    local v = self.container[k]
    if v.name == name then amount = amount + 1 end
  end
  return amount
end


function ObjectHandler:update(dt)
	for k = #self.container, 1, -1 do
    local v = self.container[k]
		if not v.removed then
			v:update(dt)
		else
			table.remove(self.container, k)
		end
	end
end


function ObjectHandler:draw()
	for k = 1, #self.container do
    local v = self.container[k]
		v:draw()
	end
end


function ObjectHandler:mousepressed(...)
  for _,v in ipairs(self.container) do
    if v.mousepressed then v:mousepressed(...) end
  end
end


function ObjectHandler:mousereleased(...)
  for _,v in ipairs(self.container) do
    if v.mousereleased then v:mousereleased(...) end
  end
end


function ObjectHandler:keypressed(...)
  for _,v in ipairs(self.container) do
    if v.keypressed then v:keypressed(...) end
  end
end


function ObjectHandler:keyreleased(x, y, button)
  for _,v in ipairs(self.container) do
    if v.keyreleased then v:keyreleased(x, y, button) end
  end
end

return ObjectHandler
