export class Stairs extends Entity
  new: (x, y) =>
    sprite = sprites.stairs
    x = x - sprite.width / 2
    y = y - sprite.height / 2
    super x, y, sprite