do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    open = function(self)
      if self.closed and player.pos.y >= self.pos.y + self.dim.y then
        self:changeSprite(sprites.chestOpen)
        self:setPosition(Vector(self.pos.x, self.pos.y + self.heightDiff))
        self.closed = false
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y)
      _class_0.__parent.__init(self, x, y, sprites.chestClosed)
      self.closed = true
      self.heightDiff = sprites.chestClosed.height - sprites.chestOpen.height
    end,
    __base = _base_0,
    __name = "Chest",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Chest = _class_0
end
