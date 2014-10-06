
local Fader = {}
local _r, _g, _b, _a = 0, 0, 0, 0
local _state = "ready"
local _scene, _speed

------------------------
-- // Dependencies \\ --
------------------------
local SceneManager = require("libs.SceneManager")


function Fader.clear()
  _scene = ""
  _state = "ready"
  _r, _g, _b, _a = 0, 0, 0, 0
end


function Fader.fadeTo(scene, speed)
  _scene = scene
  _speed = speed or 400
  _state = "out"
end


function Fader.update(dt)
  if _state == "out" then
    if _a < 245 then
      _a = _a + _speed * dt
    else
      _a = 255
      if _scene ~= "exit" then SceneManager.setScene(_scene)
      else love.event.quit() end
      _state = "in"
    end
  end
  if _state == "in" then
    if _a > 10 then
      _a = _a - _speed * dt
    else
      _a = 0
      _state = "ready"
    end
  end
end


function Fader.draw()
  love.graphics.setColor(_r, _g, _b, _a)
  love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
  love.graphics.setColor(255, 255, 255, 255)
end

return Fader