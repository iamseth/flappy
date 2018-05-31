local Pipe = require 'pipe'
local Bird = require 'bird'

local game = { bird = nil, pipe = nil, score = 0, state = 'start' }


function love.load()
  game.pipe = Pipe:new()
  game.bird = Bird:new()
end

function love.update(dt)
  if game.state == 'end' then return end

  -- TODO fix this hack. Need to determine when bird crosses through a pipe.
  if game.bird.x > game.pipe.x and (game.bird.x < game.pipe.x + 5) then
    game.score = game.score + 1
  end
  game.pipe:update(dt)
  game.bird:update(dt)



  if not(game.bird.x + game.bird.width < game.pipe.x  or game.pipe.x + game.pipe.width < game.bird.x or game.bird.y + game.bird.height < game.pipe.bottom.y or game.pipe.bottom.y + game.pipe.bottom.length < game.bird.y ) then
    game.state = 'end'
  end

  if not(game.bird.x + game.bird.width < game.pipe.x  or game.pipe.x + game.pipe.width < game.bird.x or game.bird.y + game.bird.height < game.pipe.top.y or game.pipe.top.y + game.pipe.top.length < game.bird.y ) then
    game.state = 'end'
  end




  --if game.bird.x + game.bird.width > game.pipe.x then
   -- if (game.bird.y <= game.pipe.top_height) or (game.bird.y >= game.pipe.top_height + game.pipe.gap) then
    --  game.state = 'end'
    --end
end

function love.draw()
  game.pipe:draw()
  game.bird:draw()

  love.graphics.print(game.score, 100, 100)
end
