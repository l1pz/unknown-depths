import floor from math
export class Entity
  new: (x, y, sprite) =>
    @pos = Vector x, y
    @changeSprite sprite, false
    @body   = world\add @, @pos.x, @pos.y, @dim.x, @dim.y
  
  filter: (item, other) ->
    return "cross"

  changeSprite: (@sprite, update = true) =>
    @dim    = Vector @sprite.width, @sprite.height
    @offset = @dim / 2
    if update
      world\update @, @pos.x, @pos.y, @dim.x, @dim.y

  draw: (offset = false) =>
    love.graphics.setColor @sprite.color
    if debugDrawSprites
      love.graphics.draw @sprite.img, floor(@pos.x), floor(@pos.y)
    if debugDrawCollisionBoxes
      x, y, w, h = world\getRect @
      love.graphics.rectangle "line", x, y, w, h
    
  update: =>

  setPosition: (@pos) =>
    world\update @, @pos.x, @pos.y

  move: (velocity) =>
    goal = @pos + velocity
    actual = Vector!
    local cols, len
    actual.x, actual.y, cols, len = world\move @, goal.x, goal.y, @filter
    @pos = actual
    if @onCollision then @onCollision cols

  onCollision: (cols) =>
    for col in *cols
      other = col.other
      switch other.__class
        when Player
          other\damage!
