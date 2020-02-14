export class Player extends Entity
  new: (x, y) =>
    super x, y, sprites.player
    @speed = 96
    @movementDir = Vector!
    @health = 6
    @gold = 0
    @keys = 0
    @bombs = 0
    @weapon = Bow!
    @spell = nil
    @disableMovement = false
    @disableAttacking = false
    @invulnurable = false
    @enableDraw = true

  filter: (item, other) ->
    switch other.__class
      when Wall then "slide"
      when Chest then "slide"
      when Stairs then "cross"
      when Door
        if other.closed then "slide" else "cross"
      when Undead then "slide"

  update: (dt) => 
    ix, iy = input\get "move"
    @movementDir = Vector ix, iy
    velocity = @movementDir * @speed * dt
    unless @disableMovement
      @move velocity
    items, len = world\queryRect @pos.x, @pos.y, @dim.x, @dim.y
    @disableAttacking = false
    for _, item in pairs items
        if item.__class == Door then
          @disableAttacking = true
    @weapon\update dt

  damage: =>
    unless @invulnurable
      camera\shake 2, 1
      @health -= 1
      if @health == 0
        fadeOut(-> manager\enter states.death)
      @invulnurable = true
      fn = -> @invulnurable = false
      @flash!
      tick.delay(fn, @, 1)

  flash: =>
    if @invulnurable
      if @enableDraw 
        @enableDraw = false
        tick.delay(@flash, @, 0.05)
      else 
        @enableDraw = true
        tick.delay(@flash, @, 0.05)
    else 
      @enableDraw = true

  draw: =>
    if @enableDraw
      super!
    @weapon\draw!

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      switch other.__class
        when Door
          other\checkCurrentRoom!
        when Chest
          other\open!
        when Stairs
          nextDungeon!
        when Undead
          @damage!

  setPosition: (pos) =>
    super pos - @offset

  
        


  
  
  
  
  
  
