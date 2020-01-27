local floor
floor = math.floor
do
  local _class_0
  local _base_0 = {
    changeSprite = function(self, sprite, update)
      if update == nil then
        update = true
      end
      self.sprite = sprite
      self.dim = Vector(self.sprite:getWidth(), self.sprite:getHeight())
      local halfDim = self.dim / 2
      self.offset = Vector(floor(halfDim.x), floor(halfDim.y))
      if update then
        return world:update(self, self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      end
    end,
    draw = function(self)
      love.graphics.setColor(self.color)
      if debugDrawSprites then
        love.graphics.draw(self.sprite, floor(self.x), floor(self.y))
      end
      if debugDrawCollisionBoxes then
        local x, y, w, h = world:getRect(self)
        return love.graphics.rectangle("line", x, y, w, h)
      end
    end,
    refreshColors = function(self)
      self.colors = colors[self.colorType][self.colorName]
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, sprite, colorType, colorName)
      if colorType == nil then
        colorType = "normal"
      end
      if colorName == nil then
        colorName = "foreground"
      end
      self.colorType, self.colorName = colorType, colorName
      self.pos = Vector(x, y)
      self:changeSprite(sprite, false)
      self.color = colors[colorType][colorName]
      self.body = world:add(self, self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      self.filter = function(item, other)
        return "cross"
      end
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
