-- Define a Bird class to represent a self object.

local Bird = {}
Bird.__index = Bird


function Bird:new()
    local this = {
        x = 200,
        y = love.graphics.getHeight() / 2,
        width = 20,
        height = 20,
        color = {255, 255, 0}
    }
    setmetatable(this, self)
    return this
end


function Bird:update(dt)
    self.y = self.y + 200 * dt
    if love.keyboard.isDown('space') then
        self.y = self.y - 10
    end
end


function Bird:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end


return Bird
