export class UI
  new: (@width, @height) =>
    @textHeight = 4
    @imageHeight = 12
    
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
    @drawFrame "weapon", player.weapon, 144
    @drawFrame "spell", player.weapon, 176
    @drawHealth!

  text: (s, x, y, center = false) =>
    s= s\upper!
    offset = if center then font\getWidth(s) / 2 else 0
    love.graphics.print( s, x - offset, y)
  
  drawFrame: (title, item, x) =>
    love.graphics.setColor sprites.frame.color
    frameWidth = sprites.frame.width
    frameHeight = sprites.frame.height
    fx, fy = x, @imageHeight
    @text title, fx + frameWidth / 2, @textHeight, true
    love.graphics.draw sprites.frame.img, fx, fy

    love.graphics.setColor item.sprite.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw item.sprite.img, fx + dx - item.offset.x, fy + dy - item.offset.y
  drawHealth: =>
    hx = 212
    hy = @imageHeight
    love.graphics.setColor sprites.heart.color
    @text "health", hx + 13, 4, true
    for heart = 0, player.health - 1
      hhx = hx + heart % 3 * 10
      hhy = if heart < 3 then hy else hy + sprites.heart.height + 2
      love.graphics.draw sprites.heart.img, hhx, hhy

  