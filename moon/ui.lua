do
  local _class_0
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle("fill", 0, 0, self.width, self.height)
      self:drawFrame("weapon", player.weapon, 144)
      self:drawFrame("spell", player.weapon, 176)
      return self:drawHealth()
    end,
    text = function(self, s, x, y, center)
      if center == nil then
        center = false
      end
      s = s:upper()
      local offset
      if center then
        offset = font:getWidth(s) / 2
      else
        offset = 0
      end
      return love.graphics.print(s, x - offset, y)
    end,
    drawFrame = function(self, title, item, x)
      love.graphics.setColor(self.fgColor)
      local frameWidth = sprites.frame:getWidth()
      local frameHeight = sprites.frame:getHeight()
      local fx, fy = x, self.imageHeight
      self:text(title, fx + frameWidth / 2, self.textHeight, true)
      love.graphics.draw(sprites.frame, fx, fy)
      love.graphics.setColor(item.color)
      local dx, dy = frameWidth / 2, frameHeight / 2
      return love.graphics.draw(item.sprite, fx + dx - item.offset.x, fy + dy - item.offset.y)
    end,
    drawHealth = function(self)
      love.graphics.setColor(colors["normal"]["red"])
      local hx = 212
      local hy = self.imageHeight
      self:text("health", hx + 13, 4, true)
      for heart = 0, player.health - 1 do
        local hhx = hx + heart % 3 * 10
        local hhy
        if heart < 3 then
          hhy = hy
        else
          hhy = hy + sprites.heart:getHeight() + 2
        end
        love.graphics.draw(sprites.heart, hhx, hhy)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, width, height, fgColor)
      self.width, self.height, self.fgColor = width, height, fgColor
      self.textHeight = 4
      self.imageHeight = 12
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
