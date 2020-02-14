export class Arrow extends Entity

  onCollision: (cols) =>
    for col in *cols
      
      other = col.other
      switch other.__class
        when Undead 
          other\damage @damage
          @destroy!
        when Wall
          @stuck = true
        when Chest
          @stuck = true

  new: (pos, @dir) =>
    super pos.x - 2, pos.y - 2, sprites.arrow
    @stuck = false
    @speed = 200
    @damage = 1
    @filter = (item, other) ->
      switch other.__class
        when Player
          return "cross"
        when Arrow
          return "cross"
        when Stairs
          return "cross"
      return "touch"

  update: (dt) =>
    unless @stuck
      @move @dir * @speed * dt

  destroy: () =>
    dungeon.currentRoom\removeEntity @
    
  
  
  
    