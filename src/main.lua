local Pipe = require 'pipe'
local Bird = require 'bird'

local game = {}
local bird = nil
local pipe = nil


function love.load()
    game.reset()
end


function game.reset()
    game.score = 0
    game.state = 'start'
    pipe = Pipe:new()
    bird = Bird:new()
end


function love.update(dt)
    if not(game.state == 'run') then
        return
    end

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
    if (game.state == 'start') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Press space to begin.', 200, 200, 600, 'center')
    end

    if (game.state == 'pause') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Game Paused', 200, 200, 600, 'center')
    end

    if (game.state == 'end') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Game Over', 200, 200, 600, 'center')
        love.graphics.printf('Press enter to restart.', 200, 500, 600, 'center')
    end


    pipe:draw()
    bird:draw()

    -- Print score to screen.
    love.graphics.setFont(love.graphics.newFont(40))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(game.score, love.graphics.getWidth() / 2, 100)
end


function love.keyreleased(key)
    if (game.state == 'start' or game.state == 'pause') and key == 'space' then
        game.state = 'run'
    end
    if key == 'p' then
        if not(game.state == 'pause') then
            game.state = 'pause'
        else
            game.state = 'run'
        end
    end

    if game.state == 'end' and key == 'return' then
        game.reset()
        game.state = 'start'
    end
end


function love.focus(f)
    if game.state == 'run' and not(f) then
        game.state = 'pause'
    end
end
