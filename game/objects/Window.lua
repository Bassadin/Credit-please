

-- // Window \\ --
-----------------
local Object = require("game.objects.Object")
local Window = Object:create()

--() Shortcuts ()--
-------------------
local graphics = love.graphics

-- // Dependencies \\ --
------------------------
local Console = require("game.objects.Console")


-- Variables
local clouds = {}
local cloudImage = graphics.newImage("assets/gfx/game_clouds.png")
local quads = {
  graphics.newQuad(0, 0, 15, 4, cloudImage:getWidth(), cloudImage:getHeight()),
  graphics.newQuad(15, 0, 15, 4, cloudImage:getWidth(), cloudImage:getHeight()),
  graphics.newQuad(30, 0, 15, 4, cloudImage:getWidth(), cloudImage:getHeight()),
  }
local function newCloud()
  local self = Window
  local cloud = {}
  cloud.quad = quads[math.random(1, #quads)]
  cloud.x = self.x + self.w
  cloud.y = self.y + math.random(16, 48)
  cloud.w = 15 * SCALEX
  cloud.h = 4 * SCALEY
  cloud.speed = math.random(5, 20)
  table.insert(clouds, cloud)
end


function Window:setup()
  self.timer = 0
  self.cloudSpawnRate = .5
  self.textbox = Console.textbox
  self:setupObjects()
end


function Window:setupObjects()
  -- Setup Window object
  self:setPosition(440, 230)
  self:setImage(graphics.newImage("assets/gfx/game_window.png"))
end


function Window:update(dt)
  -- Generate clouds
  self.timer = self.timer + dt
  if self.timer > self.cloudSpawnRate then
    newCloud()
    self.timer = 0
    self.cloudSpawnRate = math.random(3, 6)
  end
  -- Update clouds
  for i, cloud in ipairs(clouds) do
    if TimeBox:isTimeAdvancing() then
      cloud.x = cloud.x - cloud.speed * dt
      if cloud.x + cloud.w < self.x then table.remove(clouds, i) end
    end
  end
end


function Window:draw()
  graphics.draw(self.image, self.x, self.y, 0, SCALEX, SCALEY)
  graphics.setScissor(self.x + 12, self.y, self:getWidth() - 21, self:getHeight())
  for i, cloud in ipairs(clouds) do
    graphics.draw(cloudImage, cloud.quad, cloud.x, cloud.y, 0, SCALEX, SCALEY)
  end
  graphics.setScissor()
end


function Window:mousepressed(x, y, button)
end

return Window