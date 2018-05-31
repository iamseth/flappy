-- Define a Bird class to represent a self object.

local class = require 'middleclass'
local Bird = class('Bird')


function Bird:initialize()
  self.x = 200
  self.y = love.graphics.getHeight() / 2
  self.width = 20
  self.height = 20
  self.color = {255, 255, 0}
end


function Bird:update(dt)
  self.y = self.y + 200 * dt
  if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
    self.y = self.y - 10
  end
end


function Bird:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end


return Bird
