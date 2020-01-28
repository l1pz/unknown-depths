do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      local ix, iy = input:get("move")
      local dir = Vector(ix, iy)
      local velocity = dir * self.speed * dt
      return self:move(velocity)
    end,
    setPosition = function(self, pos)
      self.pos = pos
      return world:update(self, pos.x, pos.y)
    end,
    move = function(self, velocity)
      local goal = self.pos + velocity
      local actual = Vector()
      local cols, len
      actual.x, actual.y, cols, len = world:move(self, goal.x, goal.y, self.filter)
      self.pos = actual
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y)
      _class_0.__parent.__init(self, x, y, sprites.player, "normal", "blue")
      self.speed = 96
      self.health = 6
      self.filter = function(item, other)
        local _exp_0 = other.__class
        if Wall == _exp_0 then
          return "slide"
        elseif Door == _exp_0 then
          return "cross"
        end
      end
      self.weapon = Weapon()
    end,
    __base = _base_0,
    __name = "Player",
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
  Player = _class_0
end
