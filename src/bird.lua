-- Define a Bird class to represent a self object.

local Animation = require('animation')

local Bird = {}
Bird.__index = Bird


function Bird:new(params)
    local this = {
        debug = params.debug == true or false,
        x = 200,
        y = love.graphics.getHeight() / 2,
        width = 96,
        height = 95,
        color = { 255, 255, 0 },
        texture = love.graphics.newImage('assets/sprites.png'),
    }

    this.hitbox = {
        ox = 30,
        oy = 15,
        width = 45,
        height = 45
    }

    this.animation = Animation:create({
        texture = this.texture,
        frames = {
            love.graphics.newQuad(0, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width * 2, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width * 3, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width * 4, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width * 5, 0, this.width, this.height, this.texture:getDimensions()),
            love.graphics.newQuad(this.width * 6, 0, this.width, this.height, this.texture:getDimensions())
        },
        interval = 0.08
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
    love.graphics.setColor(self.color)
    love.graphics.draw(self.texture, self.animation:getCurrentFrame(), self.x, self.y, 0, 1, 1)

    if self.debug then
        love.graphics.setColor(0, 0, 255)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', self.x + self.hitbox.ox,
                                self.y + self.hitbox.oy,
                                self.hitbox.width, self.hitbox.height)
    end
end


function Bird:isCollision(pipe)
    if not(self.x + self.hitbox.ox + self.hitbox.width < pipe.x
        or pipe.x + pipe.width < self.x + self.hitbox.ox
        or self.y + self.hitbox.oy + self.hitbox.height < pipe.bottom.y
        or pipe.bottom.y + pipe.bottom.length < self.y + self.hitbox.oy) then
        return true
    elseif not(self.x + self.hitbox.ox + self.hitbox.width < pipe.x
            or pipe.x + pipe.width < self.x + self.hitbox.ox
            or self.y + self.hitbox.oy + self.hitbox.height < pipe.top.y
            or pipe.top.y + pipe.top.length < self.y + self.hitbox.oy ) then
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
