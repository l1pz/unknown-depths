export class UI
  new: (@width, @height) =>
    @textHeight = 4
    @imageHeight = 12
    @counterX = width - 64 -- 116
    @weaponX = width / 2 - 16  -- 152
    @spellX = width / 2 + 16   -- 184
    @healthX = 32  -- 216
    
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
    @drawFrame "weapon", player.weapon, @weaponX
    @drawFrame "spell", player.spell, @spellX
    @drawHealth!
    @text "items", @counterX + 2, @textHeight
    @drawCounter 0, sprites.gold, player.gold
    @drawCounter 8, sprites.bomb, player.bombs
    @drawCounter 16, sprites.key, player.keys
    
  text: (s, x, y, color = colors["normal"]["white"], center = false) =>
    love.graphics.setFont fontGameplay
    s = s\upper!
    offset = if center then fontGameplay\getWidth(s) / 2 else 0
    love.graphics.setColor color
    love.graphics.print( s, x - offset, y)
  
  drawFrame: (title, item, x) =>
    love.graphics.setColor sprites.frame.color
    frameWidth = sprites.frame.width
    frameHeight = sprites.frame.height
    x = x - frameWidth / 2
    y = @imageHeight
    textColor = if item then item.sprite.color else colors["normal"]["white"]
    @text title, x + frameWidth / 2, @textHeight, textColor, true
    love.graphics.setColor colors["normal"]["white"]
    love.graphics.draw sprites.frame.img, x, y
    dx, dy = frameWidth / 2, frameHeight / 2
    if item
      item\draw x + dx - item.offset.x, y + dy - item.offset.y

  drawHealth: =>
    x = @healthX
    y = @imageHeight
    @text "health", x + 13, 4, sprites.heart.color, true
    for heart = 0, player.health - 1
      hx = x + heart % 3 * 10
      hy = if heart < 3 then y else y + sprites.heart.height + 2
      love.graphics.setColor sprites.heart.color
      love.graphics.draw sprites.heart.img, hx, hy
      
  drawCounter: (yOffset, sprite, number) =>
    x = @counterX
    y = @imageHeight + yOffset
    love.graphics.setColor sprite.color
    love.graphics.draw sprite.img, x, y
    @text " x #{number}", x + sprite.width, y, sprite.color

  