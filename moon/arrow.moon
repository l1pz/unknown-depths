export class Arrow extends Entity

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      color = other.sprite.color
      switch other.__class
        when Undead 
          other\damage @damage
      unless other.__class == Arrow or other.__class == Player or other.__class == Stairs
        @destroy color

  new: (pos, @dir) =>
    super pos.x - 2, pos.y - 2, sprites.arrow
    @stuck = false
    @speed = 200
    @damage = 1
  
  filter: (item, other) ->
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

  destroy: (color) =>
    with player.weapon.psystem
      \setDirection (@dir * -1).angle
      \setPosition @pos.x, @pos.y
      \setColors color[1], color[2], color[3], 1
      \emit 3
    dungeon.currentRoom\removeEntity @
    
  
  
  
    