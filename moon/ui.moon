export class UI
  new: (@width, @height, @fgColor) =>
    
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
    @drawPlayerWeapon!
    @drawPlayerSpell!
  
  drawPlayerWeapon: =>
    weapon = player.weapon

    love.graphics.setColor @fgColor
    frameWidth = sprites.weaponFrame\getWidth!
    frameHeight = sprites.weaponFrame\getHeight!
    fx, fy = 144, (@height - frameHeight) / 2 
    love.graphics.draw sprites.weaponFrame, fx, fy

    love.graphics.setColor weapon.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw weapon.sprite, fx +dx - weapon.offset.x, fy + dy - weapon.offset.y + 4
  drawPlayerSpell: =>
    weapon = player.weapon

    love.graphics.setColor @fgColor
    frameWidth = sprites.spellFrame\getWidth!
    frameHeight = sprites.spellFrame\getHeight!
    fx, fy = 176, (@height - frameHeight) / 2 
    love.graphics.draw sprites.spellFrame, fx, fy

    love.graphics.setColor weapon.color
    dx, dy = frameWidth / 2, frameHeight / 2
    love.graphics.draw weapon.sprite, fx +dx - weapon.offset.x, fy + dy - weapon.offset.y + 4
  