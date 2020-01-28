export class UI
  new: (@width, @height, @fgColor) =>
    
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
    @drawWeapon!
    @drawSpell!
    @drawHealth!
  
  drawWeapon: =>
    weapon = player.weapon

    love.graphics.setColor @fgColor
    frameWidth = sprites.weaponFrame\getWidth!
    frameHeight = sprites.weaponFrame\getHeight!
    fx, fy = 144, (@height - frameHeight) / 2 
    love.graphics.draw sprites.weaponFrame, fx, fy

    love.graphics.setColor weapon.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw weapon.sprite, fx +dx - weapon.offset.x, fy + dy - weapon.offset.y + 4
  drawSpell: =>
    weapon = player.weapon

    love.graphics.setColor @fgColor
    frameWidth = sprites.spellFrame\getWidth!
    frameHeight = sprites.spellFrame\getHeight!
    fx, fy = 176, (@height - frameHeight) / 2 
    love.graphics.draw sprites.spellFrame, fx, fy

    love.graphics.setColor weapon.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw weapon.sprite, fx +dx - weapon.offset.x, fy + dy - weapon.offset.y + 4
  drawHealth: =>
    love.graphics.setColor colors["normal"]["red"]
    sx = 212
    healthTextWidth = sprites.healthText\getWidth!
    love.graphics.draw sprites.healthText, sx + 3 , 5
    heartHeight = sprites.heart\getHeight!
    
    for heart = 0, player.health - 1
      q = if heart > 2 then 0.4 else 0.65
      fx, fy = sx + heart % 3 * 10, @height * q
      love.graphics.draw sprites.heart, fx, fy

  