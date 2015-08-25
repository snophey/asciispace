-- general utils functionality
debug = true

function dbg(str)
  if debug then
    print(str)
  end
end


-- load resources (more love callbacks below)
function love.load()
  local fontsize = 32
  font = love.graphics.newFont("unispace bd.ttf", fontsize)
  love.graphics.setFont(font)

  screen = {
    w = love.graphics.getWidth(),
    h = love.graphics.getHeight(),
  }

  player.width = font:getWidth(player.playerstr)
  player.pos = {
    x = screen.w / 2,
    y = screen.h - font:getHeight()
  }

  love.graphics.setBackgroundColor(255, 255, 255)
end


-- game logic
player = {
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
    shoot = 'up',
  }
}

function player:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.print(self.playerstr, self.pos.x, self.pos.y)
end

function player:move(dt)
  if love.keyboard.isDown(self.controls.left) then
    if self.pos.x > 0 then
      self.pos.x = self.pos.x - self.speed * dt
    end
  elseif love.keyboard.isDown(self.controls.right) then
    if self.pos.x + self.width < screen.w then
      self.pos.x = self.pos.x + self.speed * dt
    end
  end
end

function player:shoot()
  return Projectile:new(self.pos.x, self.pos.y - self.projectile_y_offset)
end

Projectile = {
  projstr = "|",
  speed = 500,
  color = {
    r = 0,
    g = 0,
    b = 0
  },
  projectiles = {},
}
Projectile.__index = Projectile
function Projectile:new(x,y)
  local pr = setmetatable({}, self)
  pr.pos = {x = x, y = y}
  self.projectiles[#self.projectiles+1] = pr
  return pr
end

function Projectile:move(dt)
  self.pos.y = self.pos.y - self.speed * dt
end

function Projectile:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.print(self.projstr, self.pos.x, self.pos.y)
end

function Projectile:moveProjectiles(dt)
  for i,proj in ipairs(self.projectiles) do
    proj:move(dt)
  end
end

function Projectile:drawProjectiles()
  for i,proj in ipairs(self.projectiles) do
    proj:draw()
  end
end


-- love callbacks

function love.draw()
  love.graphics.clear()
  player:draw()
  Projectile:drawProjectiles()
end

function love.update(dt)
  player:move(dt)
  Projectile:moveProjectiles(dt)
end

function love.keypressed(key)
  if key == player.controls.shoot then
    player:shoot()
  end
end
