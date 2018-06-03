-- Define a class for handling menu items.

local Menu = {}
Menu.__index = Menu


function Menu:new()
    local this = {}
    setmetatable(this, self)
    return this
end


function Menu:draw(state)
    if (state == 'start') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Press space to begin.', 200, 200, 600, 'center')
    elseif (state == 'pause') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Game Paused', 200, 200, 600, 'center')
    elseif (state == 'end') then
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf('Game Over', 200, 200, 600, 'center')
        love.graphics.printf('Press enter to restart.', 200, 500, 600, 'center')
    end
end


return Menu
