local floor
floor = math.floor
do
  local _class_0
  local _base_0 = {
    changeSprite = function(self, sprite)
      self.sprite = sprite
      self.dim = Vector(self.sprite.width, self.sprite.height)
      self.offset = self.dim / 2
    end,
    drawIcon = function(self, x, y)
      love.graphics.setColor(self.sprite.color)
      return love.graphics.draw(self.sprite.img, x, y)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, sprite)
      return self:changeSprite(sprite)
    end,
    __base = _base_0,
    __name = "Item"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Item = _class_0
end
