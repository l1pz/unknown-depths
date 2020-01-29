export class UI
  new: (@width, @height, @fgColor) =>
    @textHeight = 4
    @imageHeight = 12
    
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
    @drawFrame "weapon", player.weapon, 144
    @drawFrame "spell", player.weapon, 176
    @drawHealth!
    --144, 176

  text: (s, x, y, center = false) =>
    s= s\upper!
    offset = if center then font\getWidth(s) / 2 else 0
    love.graphics.print( s, x - offset, y)
  
  drawFrame: (title, item, x) =>
    love.graphics.setColor @fgColor
    frameWidth = sprites.frame\getWidth!
    frameHeight = sprites.frame\getHeight!
    fx, fy = x, @imageHeight
    @text title, fx + frameWidth / 2, @textHeight, true
    love.graphics.draw sprites.frame, fx, fy

    love.graphics.setColor item.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw item.sprite, fx + dx - item.offset.x, fy + dy - item.offset.y
  drawHealth: =>
    love.graphics.setColor colors["normal"]["red"]
    hx = 212
    hy = @imageHeight
    --love.graphics.draw sprites.healthText, sx + 3 , 5
    @text "health", hx + 13, 4, true
    for heart = 0, player.health - 1
      hhx = hx + heart % 3 * 10
      hhy = if heart < 3 then hy else hy + sprites.heart\getHeight! + 2
      love.graphics.draw sprites.heart, hhx, hhy

  