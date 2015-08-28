Score = {
  score = 0,
  increment = function() return (screen.h - Player.pos.y) / 10 end,
  pos = {},
}

function Score:init(screen, font)
  util.dbg("Initializing score module...")
  self.font = font
  self.pos = {
    x = 0,
    y = screen.h - font:getHeight(),
  }
  util.dbg("...done")
end

function Score:draw()
  love.graphics.setFont(self.font)
  local scorestr = "Score: " .. math.floor(self.score)
    .. " (+" .. math.floor(self.increment()) .. ")"
  love.graphics.print(scorestr, self.pos.x, self.pos.y)
end

function Score:update(dt)
  self.score = self.score + self.increment() * dt
end

return Score
