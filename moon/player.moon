export class Player extends Entity
  new: (x, y) =>
    super x, y, sprites.player
    @speed = 96
    @health = 6
    @gold = 99
    @keys = 99
    @bombs = 99
    @filter = (item, other) ->
      switch other.__class
        when Wall return "slide"
        when Door return "cross"
    @weapon = nil
    @spell = nil

  update: (dt) => 
    ix, iy = input\get "move"
    dir = Vector ix, iy
    velocity = dir * @speed * dt
    @move velocity

  

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      if other.__class == Wall
        other\checkCurrentRoom


  
  
  
  
  
  
