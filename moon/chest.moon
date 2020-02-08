export class Chest extends Entity
  new: (x, y) =>
    super x, y, sprites.chestClosed
    @closed = true
  open: =>
    if @closed and player.pos.y >= @pos.y + @dim.y
      @changeSprite sprites.chestOpen
      closed = false