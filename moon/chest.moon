export class Chest extends Entity
  new: (x, y) =>
    x = x - sprites.chestClosed.width / 2
    y = y - sprites.chestClosed.height / 2
    super x, y, sprites.chestClosed
    @closed = true
    @heightDiff = sprites.chestClosed.height - sprites.chestOpen.height
  open: =>
    if @closed and player.pos.y >= @pos.y + @dim.y
      @changeSprite sprites.chestOpen
      @setPosition Vector(@pos.x, @pos.y + @heightDiff)
      @closed = false