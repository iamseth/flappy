--

local Pipe = require('pipe')
local Bird = require('bird')
local Menu = require('menu')
local Score = require('score')

local game, pipe, bird, menu, score

local reset = function()
    pipe = Pipe:new()
    bird = Bird:new()
    score = Score:new()
    menu = Menu:new()
    game = { state = 'start', score = 0 }
end


function love.load()
    reset()
end


function love.quit()
    score:save()
end


function love.update(dt)
    if not(game.state == 'run') then return end

    -- handles scoring.
    -- TODO fix this hack. Need to determine when bird crosses through a pipe.
    if bird.x > pipe.x and (bird.x < pipe.x + 5) then
        score:increment()
    end

    -- handle deaths
    if not(bird.x + bird.width < pipe.x  or pipe.x + pipe.width < bird.x or bird.y + bird.height < pipe.bottom.y or pipe.bottom.y + pipe.bottom.length < bird.y ) then
        game.state = 'end'
        score:save()
    elseif not(bird.x + bird.width < pipe.x  or pipe.x + pipe.width < bird.x or bird.y + bird.height < pipe.top.y or pipe.top.y + pipe.top.length < bird.y ) then
        game.state = 'end'
        score:save()
    elseif bird.y > love.graphics.getHeight() then
        game.state = 'end'
        score:save()
    end

    pipe:update(dt)
    bird:update(dt)
end


function love.draw()
    pipe:draw()
    bird:draw()
    score:draw()
    menu:draw(game.state)
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
        reset()
        game.state = 'start'
    end
end


function love.focus(f)
    if game.state == 'run' and not(f) then
        game.state = 'pause'
    end
end
