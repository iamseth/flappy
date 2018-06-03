-- Define a Bird class to represent a self object.

local Animation = require('animation')

local Bird = {}
Bird.__index = Bird


function Bird:new()
    local this = {
        x = 200,
        y = love.graphics.getHeight() / 2,
        width = 76,
        height = 32,
        texture = love.graphics.newImage('assets/spritesheet.png'),
    }

    this.animation = Animation:create({
        texture = this.texture,
        frames = {
            love.graphics.newQuad(0, 0, 76, 32, this.texture:getDimensions()),
            love.graphics.newQuad(0, 32, 76, 32, this.texture:getDimensions())
        },
        interval = 0.2
    })

    this.currentFrame = this.animation:getCurrentFrame()

    setmetatable(this, self)
    return this
end


function Bird:update(dt)
    self.y = self.y + 200 * dt
    if love.keyboard.isDown('space') then
        self.y = self.y - 10
    end
    self.animation:update(dt)
end


function Bird:draw()
    love.graphics.draw(self.texture, self.animation:getCurrentFrame(), self.x, self.y, 0, 1, 1)
    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height) -- FIXME remove after bugging hitbox
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
