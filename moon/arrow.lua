do
  local _class_0
  local onCollision
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      if not (stuck) then
        return self:move(self.dir * self.speed * dt, onCollision)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos, dir)
      self.dir = dir
      _class_0.__parent.__init(self, pos.x - 2, pos.y - 2, sprites.arrow)
      self.stuck = false
      self.speed = 200
      self.filter = function(item, other)
        local _exp_0 = other.__class
        if Player == _exp_0 then
          return "cross"
        elseif Arrow == _exp_0 then
          return "cross"
        elseif Stairs == _exp_0 then
          return "cross"
        end
        return "touch"
      end
    end,
    __base = _base_0,
    __name = "Arrow",
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
  local self = _class_0
  onCollision = function(cols)
    for _index_0 = 1, #cols do
      local col = cols[_index_0]
      local other = col.other
      if other.__class == Wall then
        self.stuck = true
      end
    end
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Arrow = _class_0
end
