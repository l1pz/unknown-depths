export class Undead extends Entity
  new: (x, y) =>
    super x, y, sprites.undead
    @health = 10

  damage: (d) =>
    @health -= d
    if @health == 0
      dungeon.currentRoom\removeEntity @