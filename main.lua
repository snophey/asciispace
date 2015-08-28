enum = require "enumerable.enumerable"
util = require "util"
Player = require "player"
Projectile = require "projectile"
Score = require "score"
Environment = require "environment"

-- load resources (more love callbacks below)
function love.load()
  local font_filename = "unispace bd.ttf"

  local font_msize = 32
  font_m = love.graphics.newFont(font_filename, font_msize)

  local font_ssize = 18
  font_s = love.graphics.newFont(font_filename, font_ssize)

  screen = {
    w = love.graphics.getWidth(),
    h = love.graphics.getHeight(),
  }

  Player:init(screen, font_m)
  Projectile:init(font_m)
  Score:init(screen, font_s)


  love.graphics.setBackgroundColor(255, 255, 255)
end



-- love callbacks
function love.draw()
  love.graphics.clear()
  Player:draw()
  Projectile:drawProjectiles()
  Score:draw()
end

function love.update(dt)
  Player:move(dt, screen)
  Projectile:moveObjects(dt)
  Score:update(dt)
end

function love.keypressed(key)
  if key == Player.controls.shoot then
    Player:shoot()
  end
end
