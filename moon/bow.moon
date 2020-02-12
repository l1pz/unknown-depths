export class Bow extends Item
  new: =>
    super sprites.bow

  update: =>
    if input\pressed("attack") and not player.disableAttacking
      pos = player.pos + player.offset
      ax, ay = input\get "attack"
      attackDir = Vector(ax, ay)
      arrowPos = pos + attackDir * 10
      arrow = Arrow arrowPos, attackDir
      dungeon.currentRoom.entities[arrow] = arrow
