import floor from math
export class Item
  new: (sprite) =>
    @changeSprite sprite, false
  changeSprite: (@sprite, update = true) =>
    @dim    = Vector @sprite.width, @sprite.height
    @offset = @dim / 2
  draw: (x, y)=>
    love.graphics.setColor @sprite.color
    love.graphics.draw @sprite.img, x, y 
