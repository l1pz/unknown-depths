export class Chest extends Entity
  new: (x, y) =>
    super x, y, sprites.chestClosed
    @closed = true
  open: =>
    print player.pos.y, @pos.y + @dim.y
    if @closed and player.pos.y >= @pos.y + @dim.y
      print "margin faty"
      @changeSprite sprites.chestOpen
      closed = false