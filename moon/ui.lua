do
  local _class_0
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle("fill", 0, 0, self.width, self.height)
      self:drawWeapon()
      self:drawSpell()
      return self:drawHealth()
    end,
    drawWeapon = function(self)
      local weapon = player.weapon
      love.graphics.setColor(self.fgColor)
      local frameWidth = sprites.weaponFrame:getWidth()
      local frameHeight = sprites.weaponFrame:getHeight()
      local fx, fy = 144, (self.height - frameHeight) / 2
      love.graphics.draw(sprites.weaponFrame, fx, fy)
      love.graphics.setColor(weapon.color)
      local dx, dy = frameWidth / 2, frameHeight / 2
      return love.graphics.draw(weapon.sprite, fx + dx - weapon.offset.x, fy + dy - weapon.offset.y + 4)
    end,
    drawSpell = function(self)
      local weapon = player.weapon
      love.graphics.setColor(self.fgColor)
      local frameWidth = sprites.spellFrame:getWidth()
      local frameHeight = sprites.spellFrame:getHeight()
      local fx, fy = 176, (self.height - frameHeight) / 2
      love.graphics.draw(sprites.spellFrame, fx, fy)
      love.graphics.setColor(weapon.color)
      local dx, dy = frameWidth / 2, frameHeight / 2
      return love.graphics.draw(weapon.sprite, fx + dx - weapon.offset.x, fy + dy - weapon.offset.y + 4)
    end,
    drawHealth = function(self)
      love.graphics.setColor(colors["normal"]["red"])
      local sx = 212
      local healthTextWidth = sprites.healthText:getWidth()
      love.graphics.draw(sprites.healthText, sx + 3, 5)
      local heartHeight = sprites.heart:getHeight()
      for heart = 0, player.health - 1 do
        local q
        if heart < 2 then
          q = 0.4
        else
          q = 0.65
        end
        local fx, fy = sx + heart % 3 * 10, self.height * q
        love.graphics.draw(sprites.heart, fx, fy)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, width, height, fgColor)
      self.width, self.height, self.fgColor = width, height, fgColor
    end,
    __base = _base_0,
    __name = "UI"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  UI = _class_0
end
