-- Define a Pipe class to represent a pipe object.

local class = require 'middleclass'
local Pipe = class('Pipe')


function Pipe:initialize()
  self.width = 100
  self.speed = 300
  self.color = {0, 255, 0}
  self.x = 0
  self.top = { y = 0, length = 0 }
  self.bottom = { y = 0, length = 0 }

  self:reset()
end


function Pipe:update(dt)
  self.x = self.x - self.speed * dt
  if self.x <= -self.width then
    self:reset()
  end
end


function Pipe:reset()
  -- pick a random gap
  self.gap = love.math.random(120, 170)

  -- reset x position to offscreen to the right.
  self.x = love.graphics.getWidth() + 200


  -- adjust the height of the top pipe to a random size with enough for the gap.
  self.top.length = love.math.random(self.gap, love.graphics.getHeight() - self.gap)

  -- adjust the length of the bottom pipe to the remaing space leaving room for the gap.
  self.bottom.length = (love.graphics.getHeight() - self.top.length) - self.gap

  self.bottom.y = self.top.length + self.gap
  self.top.y =  0 

end


function Pipe:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, 0, self.width, self.top.length)
  love.graphics.rectangle('fill', self.x, self.bottom.y, self.width, self.bottom.length)
end


return Pipe
