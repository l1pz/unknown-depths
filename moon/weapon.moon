import floor from math

export class Weapon extends Item
  new: (sprite, @cooldown = 0.5, @knockback = 1) =>
    @changeSprite sprite

  changeSprite: (@sprite) =>
    @dim = Vector @sprite.width, @sprite.height
    halfDim = @dim / 2
    @offset = Vector floor(halfDim.x),  floor(halfDim.y)
    
  draw: =>
    @color = @sprite.color
    love.graphics.draw @sprite.img, floor(@pos.x), floor(@pos.y)