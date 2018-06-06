

local Score = {}
Score.__index = Score


function Score:new()
    local this = {
        current = 0,
        high = 0
    }
    local data = love.filesystem.load('highscore.lua')
    if data then
        data()
        this.high = highscore -- luacheck: ignore
    end
    setmetatable(this, self)
    return this
end


function Score:increment()
    self.current = self.current + 1
    if self.current > self.high then
        self.high = self.current
    end
end


function Score:save()
    if self.current >= self.high then
        local file = love.filesystem.newFile('highscore.lua', 'w')
        file:write('highscore = ' .. self.current)
        file:close()
    end
end


function Score:draw()
    -- Print score to screen.
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(0, 0 ,0)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 50)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format('SCORE %d', self.current), 50, 15)
    love.graphics.print(string.format('HIGH SCORE %d', self.high), 300, 15)
end


return Score
