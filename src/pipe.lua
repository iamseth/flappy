-- Define a Pipe class to represent a pipe object.

local Pipe = {}
Pipe.__index = Pipe


function Pipe:new(params)
    local this = {
        debug = params.debug == true or false,
        width = 54,
        speed = 300,
        color = { 0.047, 0.486, 0.133 },
        x = params.x or 0,
        top = { y = 50, length = 0 },
        bottom = { y = 0, length = 0 },
    }
    this.ground = { height = 75 }

    setmetatable(this, self)
    return this
end


function Pipe:update(dt)
    self.x = self.x - self.speed * dt
    if self.x <= -self.width then
        self:reset()
    end
end


function Pipe:reset()
    -- Pick a random gap
    self.gap = love.math.random(220, 260)

    -- Reset x position to off screen to the right with a little randomness.
    self.x = love.graphics.getWidth() + love.math.random(250, 400)

    -- Adjust the height of the top pipe to a random size with enough for the gap.
    local minlength = 60
    local maxlength = love.graphics.getHeight() - self.gap - self.top.y - 75
    self.top.length = love.math.random(minlength, maxlength)

    -- Adjust the length of the bottom pipe to the remaing space leaving room for the gap.
    self.bottom.length = love.graphics.getHeight() - self.top.length - self.ground.height - self.gap

    self.bottom.y = self.top.length + self.gap
end


function Pipe:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.top.y, self.width, self.top.length)
    love.graphics.rectangle('fill', self.x, self.bottom.y, self.width, self.bottom.length)

    if self.debug then
        love.graphics.setColor(0, 0, 255)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', self.x, self.top.y, self.width, self.top.length)
        love.graphics.rectangle('line', self.x, self.bottom.y, self.width, self.bottom.length)
    end
end


return Pipe
