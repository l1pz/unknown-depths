export class Chest extends Entity
  new: (x, y) =>
    sprite = sprites.chestClosed
    x = x - sprite.width / 2
    y = y - sprite.height / 2
    super x, y, sprite
    @closed = true
    @heightDiff = sprites.chestClosed.height - sprites.chestOpen.height
  open: =>
    if @closed --and player.pos.y >= @pos.y + @dim.y
      @changeSprite sprites.chestOpen
      @setPosition Vector(@pos.x, @pos.y + @heightDiff)
      @closed = false