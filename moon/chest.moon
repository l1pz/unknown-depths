export class Chest extends Entity
  new: (x, y) =>
    super x, y, sprites.chestClosed
    @closed = true
  open: =>
    if closed
      @changeSprite sprites.chestOpen
      closed = false