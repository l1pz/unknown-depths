local floor
floor = math.floor
do
  local _class_0
  local _base_0 = {
    filter = function(item, other)
      return "cross"
    end,
    changeSprite = function(self, sprite, update)
      if update == nil then
        update = true
      end
      self.sprite = sprite
      self.dim = Vector(self.sprite.width, self.sprite.height)
      self.offset = self.dim / 2
      if update then
        return world:update(self, self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      end
    end,
    draw = function(self, offset)
      if offset == nil then
        offset = false
      end
      love.graphics.setColor(self.sprite.color)
      if debugDrawSprites then
        love.graphics.draw(self.sprite.img, floor(self.pos.x), floor(self.pos.y))
      end
      if debugDrawCollisionBoxes then
        local x, y, w, h = world:getRect(self)
        return love.graphics.rectangle("line", x, y, w, h)
      end
    end,
    update = function(self) end,
    setPosition = function(self, pos)
      self.pos = pos
      return world:update(self, self.pos.x, self.pos.y)
    end,
    move = function(self, velocity)
      local goal = self.pos + velocity
      local actual = Vector()
      local cols, len
      actual.x, actual.y, cols, len = world:move(self, goal.x, goal.y, self.filter)
      self.pos = actual
      if self.onCollision then
        return self:onCollision(cols)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, sprite)
      self.pos = Vector(x, y)
      self:changeSprite(sprite, false)
      self.body = world:add(self, self.pos.x, self.pos.y, self.dim.x, self.dim.y)
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
