export class Undead extends Entity
  new: (x, y) =>
    super x, y, sprites.undead
    @health = 5
    @enableDraw = true

  damage: (d) =>
    @health -= d
    @enableDraw = false
    fn = -> @enableDraw = true
    tick.delay(fn, @, 0.02)
    if @health == 0
      dungeon.currentRoom\removeEntity @


  draw: =>
    if @enableDraw then super!