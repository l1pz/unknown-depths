export class Player extends Entity
  new: (x, y) =>
    super x, y, sprites.player
    @speed = 96
    @health = 6
    @gold = 99
    @keys = 99
    @bombs = 99
    @weapon = nil
    @spell = nil

  filter: (item, other) ->
    switch other.__class
      when Wall return "slide"
      when Chest return "slide"
      when Door return "cross"

  update: (dt) => 
    ix, iy = input\get "move"
    dir = Vector ix, iy
    velocity = dir * @speed * dt
    @move velocity

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      if other.__class == Door
        other\checkCurrentRoom!
      if other.__class == Chest
        other\open!
        


  
  
  
  
  
  
