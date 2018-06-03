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


function Bird:isCollision(pipe)
    if not(self.x + self.width < pipe.x or pipe.x + pipe.width < self.x or self.y + self.height < pipe.bottom.y or pipe.bottom.y + pipe.bottom.length < self.y ) then
        return true
    elseif not(self.x + self.width < pipe.x or pipe.x + pipe.width < self.x or self.y + self.height < pipe.top.y or pipe.top.y + pipe.top.length < self.y ) then
        return true
    elseif self.y > love.graphics.getHeight() then
        return true
    end
    return false
end


-- Determine if we've flown past a pipe for scoring.
function Bird:isPastPipe(pipe)
    return self.x > pipe.x and (self.x < pipe.x + 5)
end

return Bird
