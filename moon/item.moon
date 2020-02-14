import floor from math
export class Item
  new: (sprite) =>
    @changeSprite sprite

  changeSprite: (@sprite) =>
    @dim = Vector @sprite.width, @sprite.height
    @offset = @dim / 2

  drawIcon: (x, y)=>
    love.graphics.setColor @sprite.color
    love.graphics.draw @sprite.img, x, y 
