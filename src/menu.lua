-- Define a class for handling menu items.

local Menu = {}
Menu.__index = Menu


function Menu:new()
    local this = {
        font = love.graphics.newFont(40),
        color = { 255, 255, 255 }
    }
    setmetatable(this, self)
    return this
end


function Menu:draw(state)

    -- Set some defaults.
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color)

    if (state == 'start') then
        love.graphics.printf('Press space to begin.', 200, 280, 600, 'center')
        love.graphics.setLineWidth(6)
        love.graphics.rectangle('line', 200, 200, 600, 300)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', 210, 210, 600 - 20, 300 - 20)
    elseif (state == 'pause') then
        love.graphics.printf('Game Paused', 200, 200, 600, 'center')
    elseif (state == 'end') then
        love.graphics.printf('Game Over', 200, 200, 600, 'center')
        love.graphics.printf('Press enter to restart.', 200, 500, 600, 'center')
    end
end


return Menu
