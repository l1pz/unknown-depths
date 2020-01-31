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
    @weapon = Bow!
    @spell = Ignite!
  update: (dt) => 
    ix, iy = input\get "move"
    dir = Vector ix, iy
    velocity = dir * @speed * dt
    @\move velocity
  setPosition: (@pos) =>
    world\update @, pos.x, pos.y
  move: (velocity) =>
    goal = @pos + velocity
    actual = Vector!
    local cols, len
    actual.x, actual.y, cols, len = world\move @, goal.x, goal.y, @filter
    @pos = actual
  
  
  
  
  
