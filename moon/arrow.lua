do
  local _class_0
  local onCollision
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      if not (stuck) then
        self:move(dir * 10 * dt, onCollision)
      end
      if {
        input = pressed('action')
      } then
        return {
          playerShip = shoot()
        }
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, dir)
      self.dir = dir
      self.stuck = false
      self.filter = function(item, other)
        local _exp_0 = other.__class
        if Player == _exp_0 then
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
  onCollision = function(cols) end
  local _list_0 = cols
  for _index_0 = 1, #_list_0 do
    local col = _list_0[_index_0]
    local other = col.other
    if other.__class == Wall then
      self.stuck = true
    end
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Arrow = _class_0
end
