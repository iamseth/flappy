--

-- Enable debug mode. Will turn on hitboxes and debug log output.
local debug = true

local Pipe = require('pipe')
local Bird = require('bird')
local Menu = require('menu')
local Score = require('score')

local game, pipe, pipe2, bird, menu, score


-- Helper function for resetting a game.
local reset = function()
    pipe = Pipe:new({ debug = debug })
    pipe2 = Pipe:new({ debug = debug, x = 500 })
    bird = Bird:new({ debug = debug })
    score = Score:new()
    menu = Menu:new()
    game = { state = 'start', score = 0 }
end


function love.update(dt)
    -- Only run update if we're in the run state.
    if not(game.state == 'run') then return end

    -- Check if we've collided with a pipe or ground.
    if bird:isCollision(pipe) then game.state = 'end'; score:save() end
    if bird:isCollision(pipe2) then game.state = 'end'; score:save() end

    -- Check if we've flown past a pipe to handle scoring.
    if bird:isPastPipe(pipe) then score:increment() end
    if bird:isPastPipe(pipe2) then score:increment() end

    -- Run the update function for our bird and pipe objects.
    bird:update(dt)
    pipe:update(dt)
    pipe2:update(dt)
end


function love.draw()
    bird:draw()
    pipe:draw()
    pipe2:draw()
    score:draw()
    menu:draw(game.state)
end


function love.keyreleased(key)
    -- Allow user to start game.
    if (game.state == 'start' or game.state == 'end') and key == 'space' then
        reset()
        game.state = 'run'
    end

    -- Allow user to pause/unpause game.
    if key == 'p' then
        if not(game.state == 'pause') then
            game.state = 'pause'
        else
            game.state = 'run'
        end
    end
end


function love.focus(f)
    -- Pause the game if the window loses focus.
    if game.state == 'run' and not(f) then game.state = 'pause' end
end


function love.load()
    love.graphics.setBackgroundColor(0.365, 0.58, 0.984)
    reset()
end


function love.quit()
    score:save()
end
