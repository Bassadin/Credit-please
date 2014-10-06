------------------------
-- // SceneManager \\ --
------------------------

--[[
Copyright (c) 2013 Lars Lönneker
modified with further Callbacks by Bastian Hodapp (c) 2014

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
local SceneManager        = {}
local _scenes             = {}
local _overlay, _currentScene, _mode



local function initScene(scene)
  if not scene.loaded then
    if scene.init then scene:init() end
    scene.loaded = true
  end
  if scene.enter then scene:enter() end
end


function SceneManager.newScene(scene, name)
  local _scene = scene
  _scene.name = name
  _scenes[name] = _scene
end

function SceneManager.setScene(scene)
  local _scene = _scenes[scene] or nil
  if _currentScene and _currentScene.leave then _currentScene:leave() end
  _currentScene = _scene
  SceneManager.setOverlay()
  if _scene then initScene(_scene)
  elseif scene ~= nil then assert(_scene, "Scene '"..scene.."' does not exist!")
  end
end


function SceneManager.setOverlay(scene, mode)
  local _scene = _scenes[scene]
  if _overlay and _overlay.leave then _overlay:leave() end
  _overlay = _scene
  _mode = mode
  if _scene then initScene(_scene) end
end


function SceneManager.getScene()
  return _currentScene.name or assert(_currentScene.name, "There's no scene set!")
end


function SceneManager.getOverlay()
  return _overlay
end


function SceneManager.update(dt)
  if _currentScene and _mode ~= "draw" then 
    _currentScene:update(dt)
  end
  if _overlay then _overlay:update(dt) end
end


function SceneManager.draw()
  if _currentScene then _currentScene:draw() end
  if _overlay then _overlay:draw() end
end


function SceneManager.keypressed(...)
  if _overlay and _overlay.keypressed then _overlay:keypressed(...)
  elseif _currentScene and _currentScene.keypressed  then _currentScene:keypressed(...) end
end


function SceneManager.keyreleased(...)
  if _overlay and _overlay.keyreleased then _overlay:keyreleased(...)
  elseif _currentScene and _currentScene.keyreleased then _currentScene:keyreleased(...) end
end


function SceneManager.mousepressed(...)
  if _overlay and _overlay.mousepressed then _overlay:mousepressed(...)
  elseif _currentScene and _currentScene.mousepressed then _currentScene:mousepressed(...) end
end


function SceneManager.mousereleased(...)
  if _overlay and _overlay.mousereleased then _overlay:mousereleased(...)
  elseif _currentScene and _currentScene.mousereleased then _currentScene:mousereleased(...) end
end


function SceneManager.gamepadpressed(...)
  if _overlay and _overlay.gamepadpressed then _overlay:gamepadpressed(...)
  elseif _currentScene and _currentScene.gamepadpressed then _currentScene:gamepadpressed(...) end
end


function SceneManager.gamepadreleased(...)
  if _overlay and _overlay.gamepadreleased then _overlay:gamepadreleased(...)
  elseif _currentScene and _currentScene.gamepadreleased then _currentScene:gamepadreleased(...) end
end

function SceneManager.resize(...)
  if _overlay and _overlay.resize then _overlay:resize(...)
  elseif _currentScene and _currentScene.resize then _currentScene:resize(...) end
end

function SceneManager.visible(...)
  if _overlay and _overlay.visible then _overlay:visible(...)
  elseif _currentScene and _currentScene.visible then _currentScene:visible(...) end
end

function SceneManager.quit(...)
  if _overlay and _overlay.quit then _overlay:quit(...)
  elseif _currentScene and _currentScene.quit then _currentScene:quit(...) end
end


return SceneManager
