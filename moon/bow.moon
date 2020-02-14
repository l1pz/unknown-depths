import pi from math

export class Bow extends Item
  new: =>
    super sprites.bow
    @psystem = love.graphics.newParticleSystem sprites.pixel.img, 32
    @fireRate = 10
    @attackDelay = 5/@fireRate
    @canShoot = true
    with @psystem
      \setParticleLifetime 0.1, 0.1
      \setSpeed 100
      \setSpread pi * 0.5
      \setColors 1, 1, 1, 1

  update: (dt) =>
    @psystem\update dt
    if input\pressed("attack") and not player.disableAttacking and @canShoot
      @shoot!

  shoot: =>
    @canShoot = true
    if input\down("attack") and not player.disableAttacking
      @canShoot = false
      pos = player.pos + player.offset
      ax, ay = input\get "attack"
      attackDir = Vector(ax, ay)
      if attackDir * player.movementDir == 0
        attackDir += player.movementDir * 0.2
      attackDir = attackDir.normalized
      arrowPos = pos + attackDir * 10
      arrow = Arrow arrowPos, attackDir
      dungeon.currentRoom.entities[arrow] = arrow
      tick.delay @shoot, @, @attackDelay

  draw: =>
    love.graphics.setColor 1, 1, 1
    love.graphics.draw @psystem, 0, 0
