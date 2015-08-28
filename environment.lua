-- environment objects are decorations that spawn on the upper edge of the
-- screen and then float to the bottom. They are purely cosmetic.

Environment = Projectile:new(-100, 0)
Projectile.objects = {} -- reset the table bc. we don't Environment in it
Environment.color = {r = 128, g = 128, b = 128}
Environment.speed = Projectile.speed * (-1)
Environment.max_objects = 5 -- how many Environment objects can exist at a time

function Environment:spawn()

end

function Environment:update(dt)
  self:moveObjects(dt)
end
