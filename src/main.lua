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
    -- Only run update if we're in the run state.
    if not(game.state == 'run') then return end

    -- Check if we've collided with a pipe or ground.
    if bird:isCollision(pipe) then game.state = 'end'; score:save() end

    -- Check if we've flown past a pipe to handle scoring.
    if bird:isPastPipe(pipe) then score:increment() end

    -- Run the update function for our bird and pipe objects.
    bird:update(dt)
    pipe:update(dt)
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
