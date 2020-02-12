export class Player extends Entity
  new: (x, y) =>
    super x, y, sprites.player
    @speed = 96
    @health = 6
    @gold = 0
    @keys = 0
    @bombs = 0
    @weapon = Bow!
    @spell = nil
    @disableMovement = false
    @disableAttacking = false

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
    items, len = world\queryRect @pos.x, @pos.y, @dim.x, @dim.y
    @disableAttacking = false
    for _, item in pairs items
        if item.__class == Door then
          @disableAttacking = true
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

  
        


  
  
  
  
  
  
