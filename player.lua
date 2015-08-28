-- game logic
local player = {
  playerstr = "^",
  speed = 500,  -- speed is in px/second
  projectile_y_offset = 25, -- y axis offset for the projectile spawn
  pos = {}, -- player position is set in love.load()
  color = {
    r = 0,
    g = 0,
    b = 0
  },
  controls = {
    left = 'left',
    right = 'right',
    forward = 'up',
    back = 'down',
    shoot = ' ',
  }
}

function player:init(screen, font)
  util.dbg("Initializing player module...")
  self.font = font

  self.width = self.font:getWidth(self.playerstr)
  self.height = self.font:getHeight()
  self.pos = {
    x = screen.w / 2,
    y = screen.h - self.font:getHeight()
  }
  util.dbg("...done")
end

function player:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.print(self.playerstr, self.pos.x, self.pos.y)
end

function player:move(dt, screen)
  if love.keyboard.isDown(self.controls.left) then
    if self.pos.x > 0 then
      self.pos.x = self.pos.x - self.speed * dt
    end
  elseif love.keyboard.isDown(self.controls.right) then
    if self.pos.x + self.width < screen.w then
      self.pos.x = self.pos.x + self.speed * dt
    end
  end

  if love.keyboard.isDown(self.controls.forward) then
    if self.pos.y > 0 then
      self.pos.y = self.pos.y - self.speed * dt
    end
  elseif love.keyboard.isDown(self.controls.back) then
    if self.pos.y + self.height < screen.h then
      self.pos.y = self.pos.y + self.speed * dt
    end
  end
end

function player:shoot()
  return Projectile:new(self.pos.x, self.pos.y - self.projectile_y_offset)
end

return player
