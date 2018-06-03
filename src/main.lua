local Pipe = require 'pipe'
local Bird = require 'bird'

local game = { score = 0, state = 'start' }
local bird = nil
local pipe = nil


function love.load()
  pipe = Pipe:new()
  bird = Bird:new()
end

function love.update(dt)
  if game.state == 'end' then return end

  -- TODO fix this hack. Need to determine when bird crosses through a pipe.
  if bird.x > pipe.x and (bird.x < pipe.x + 5) then
    game.score = game.score + 1
  end
  pipe:update(dt)
  bird:update(dt)


  -- Check for pipe collisions.
  if not(bird.x + bird.width < pipe.x  or pipe.x + pipe.width < bird.x or bird.y + bird.height < pipe.bottom.y or pipe.bottom.y + pipe.bottom.length < bird.y ) then
    game.state = 'end'
  end

  if not(bird.x + bird.width < pipe.x  or pipe.x + pipe.width < bird.x or bird.y + bird.height < pipe.top.y or pipe.top.y + pipe.top.length < bird.y ) then
    game.state = 'end'
  end


  -- Check for ground collisions.
  if bird.y > love.graphics.getHeight() then
    game.state = 'end'
  end

end

function love.draw()
  pipe:draw()
  bird:draw()

  -- Print score to screen.
  love.graphics.setFont(love.graphics.newFont(40))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(game.score, love.graphics.getWidth() / 2, 100)
end
