import floor from math
export class Entity
  new: (x, y, sprite) =>
    @pos = Vector x, y
    @changeSprite sprite, false
    @body   = world\add @, @pos.x, @pos.y, @dim.x, @dim.y
    @filter = (item, other) ->
      return "cross"
  changeSprite: (@sprite, update = true) =>
    @dim    = Vector @sprite.width, @sprite.height
    halfDim = @dim / 2
    @offset = Vector floor(halfDim.x),  floor(halfDim.y)
    if update
      world\update @, @pos.x, @pos.y, @dim.x, @dim.y
  draw: =>
    love.graphics.setColor @sprite.color
    if debugDrawSprites
      love.graphics.draw @sprite.img, floor(@pos.x), floor(@pos.y)
    if debugDrawCollisionBoxes
      x, y, w, h = world\getRect @
      love.graphics.rectangle "line", x, y, w, h
