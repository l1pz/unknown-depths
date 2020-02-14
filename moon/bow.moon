import pi from math

export class Bow extends Item
  new: =>
    super sprites.bow
    @psystem = love.graphics.newParticleSystem sprites.pixel.img, 32
    with @psystem
      \setParticleLifetime 0.1, 0.1
      \setSpeed 100
      \setSpread pi * 0.5
      \setColors 1, 1, 1, 1

  update: (dt, playerDir) =>
    @psystem\update dt
    if input\down("attack") and not player.disableAttacking
      
      pos = player.pos + player.offset
      ax, ay = input\get "attack"
      attackDir = Vector(ax, ay)
      if attackDir * playerDir == 0
        attackDir += playerDir * 0.4
      attackDir = attackDir.normalized
      arrowPos = pos + attackDir * 10
      arrow = Arrow arrowPos, attackDir
      dungeon.currentRoom.entities[arrow] = arrow

  draw: =>
    love.graphics.setColor 1, 1, 1
    love.graphics.draw @psystem, 0, 0
