Projectile = {
  projstr = ".",
  speed = 700,
  color = {
    r = 0,
    g = 0,
    b = 0
  },
  objects = {},
}
Projectile.__index = Projectile

function Projectile:init(font)
  util.dbg("Initializing projectile module...")
  self.font = font
  util.dbg("...done")
end

function Projectile:new(x,y)
  local pr = setmetatable({}, self)
  pr.pos = {x = x, y = y}
  self.objects[#self.objects+1] = pr
  return pr
end

function Projectile:move(dt)
  self.pos.y = self.pos.y - self.speed * dt
end

function Projectile:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.print(self.projstr, self.pos.x, self.pos.y)
end

function Projectile:moveObjects(dt)
  for i,proj in ipairs(self.objects) do
    proj:move(dt)
  end
end

function Projectile:drawProjectiles()
  for i,proj in ipairs(self.objects) do
    proj:draw()
  end
end

return Projectile
