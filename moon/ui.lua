do
  local _class_0
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle("fill", 0, 0, self.width, self.height)
      self:drawFrame("weapon", player.weapon, self.weaponX)
      self:drawFrame("spell", player.spell, self.spellX)
      self:drawHealth()
      self:text("items", self.counterX + 2, self.textHeight)
      self:drawCounter(0, sprites.gold, player.gold)
      self:drawCounter(8, sprites.bomb, player.bombs)
      return self:drawCounter(16, sprites.key, player.keys)
    end,
    text = function(self, s, x, y, color, center)
      if color == nil then
        color = colors["normal"]["white"]
      end
      if center == nil then
        center = false
      end
      love.graphics.setFont(fontGameplay)
      s = s:upper()
      local offset
      if center then
        offset = fontGameplay:getWidth(s) / 2
      else
        offset = 0
      end
      love.graphics.setColor(color)
      return love.graphics.print(s, x - offset, y)
    end,
    drawFrame = function(self, title, item, x)
      love.graphics.setColor(sprites.frame.color)
      local frameWidth = sprites.frame.width
      local frameHeight = sprites.frame.height
      x = x - frameWidth / 2
      local y = self.imageHeight
      local textColor
      if item then
        textColor = item.sprite.color
      else
        textColor = colors["normal"]["white"]
      end
      self:text(title, x + frameWidth / 2, self.textHeight, textColor, true)
      love.graphics.setColor(colors["normal"]["white"])
      love.graphics.draw(sprites.frame.img, x, y)
      local dx, dy = frameWidth / 2, frameHeight / 2
      if item then
        return item:drawIcon(x + dx - item.offset.x, y + dy - item.offset.y)
      end
    end,
    drawHealth = function(self)
      local x = self.healthX
      local y = self.imageHeight
      self:text("health", x + 13, 4, sprites.heart.color, true)
      for heart = 0, player.health - 1 do
        local hx = x + heart % 3 * 10
        local hy
        if heart < 3 then
          hy = y
        else
          hy = y + sprites.heart.height + 2
        end
        love.graphics.setColor(sprites.heart.color)
        love.graphics.draw(sprites.heart.img, hx, hy)
      end
    end,
    drawCounter = function(self, yOffset, sprite, number)
      local x = self.counterX
      local y = self.imageHeight + yOffset
      love.graphics.setColor(sprite.color)
      love.graphics.draw(sprite.img, x, y)
      return self:text(" x " .. tostring(number), x + sprite.width, y, sprite.color)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, width, height)
      self.width, self.height = width, height
      self.textHeight = 4
      self.imageHeight = 12
      self.counterX = width - 64
      self.weaponX = width / 2 - 16
      self.spellX = width / 2 + 16
      self.healthX = 32
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
