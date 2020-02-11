export class Player extends Entity
  new: (x, y) =>
    super x, y, sprites.player
    @speed = 96
    @health = 6
    @gold = 99
    @keys = 99
    @bombs = 99
    @weapon = Bow!
    @spell = nil
    @disableMovement = false

  filter: (item, other) ->
    switch other.__class
      when Wall return "slide"
      when Chest return "slide"
      when Stairs return "cross"
      when Door
        if other.closed then "slide" else "cross"

  update: (dt) => 
    ix, iy = input\get "move"
    dir = Vector ix, iy
    velocity = dir * @speed * dt
    unless @disableMovement
      @move velocity
    @weapon\update!

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      if other.__class == Door
        other\checkCurrentRoom!
      if other.__class == Chest
        other\open!
      if other.__class == Stairs
        nextDungeon!

  setPosition: (pos) =>
    super pos - @offset

  draw: =>
    super!
    pos = player.pos + player.offset
    ax, ay = input\get "attack"
    attackDir = Vector(ax, ay) * 10
    epos = pos + attackDir
    love.graphics.setColor(1, 0, 0)
    love.graphics.line(pos.x, pos.y, epos.x, epos.y)
        


  
  
  
  
  
  
