import floor from math
export class Entity
  new: (x, y, sprite, @colorType = "normal", @colorName = "foreground") =>
    @pos = Vector x, y
    @changeSprite sprite, false
    @refreshColors!
    @body   = world\add @, @pos.x, @pos.y, @dim.x, @dim.y
    @filter = (item, other) ->
      return "cross"
  changeSprite: (@sprite, update = true) =>
    @dim    = Vector @sprite\getWidth!, @sprite\getHeight!
    halfDim = @dim / 2
    @offset = Vector floor(halfDim.x),  floor(halfDim.y)
    if update
      world\update @, @pos.x, @pos.y, @dim.x, @dim.y
  draw: =>
    @color = colors[@colorType][@colorName]
    love.graphics.setColor @color
    if debugDrawSprites
      love.graphics.draw @sprite, floor(@pos.x), floor(@pos.y)
    if debugDrawCollisionBoxes
      x, y, w, h = world\getRect @
      love.graphics.rectangle "line", x, y, w, h
  refreshColors: =>
    @color = colors[@colorType][@colorName]
  
