do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    filter = function(item, other)
      local _exp_0 = other.__class
      if Wall == _exp_0 then
        return "slide"
      elseif Chest == _exp_0 then
        return "slide"
      elseif Stairs == _exp_0 then
        return "cross"
      elseif Door == _exp_0 then
        if other.closed then
          return "slide"
        else
          return "cross"
        end
      end
    end,
    update = function(self, dt)
      local ix, iy = input:get("move")
      local dir = Vector(ix, iy)
      local velocity = dir * self.speed * dt
      if not (self.disableMovement) then
        self:move(velocity)
      end
      local items, len = world:queryRect(self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      self.disableAttacking = false
      for _, item in pairs(items) do
        if item.__class == Door then
          self.disableAttacking = true
        end
      end
      return self.weapon:update()
    end,
    onCollision = function(self, cols)
      for _index_0 = 1, #cols do
        local col = cols[_index_0]
        local other = col.other
        if other.__class == Door then
          other:checkCurrentRoom()
        end
        if other.__class == Chest then
          other:open()
        end
        if other.__class == Stairs then
          nextDungeon()
        end
      end
    end,
    setPosition = function(self, pos)
      return _class_0.__parent.__base.setPosition(self, pos - self.offset)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y)
      _class_0.__parent.__init(self, x, y, sprites.player)
      self.speed = 96
      self.health = 6
      self.gold = 0
      self.keys = 0
      self.bombs = 0
      self.weapon = Bow()
      self.spell = nil
      self.disableMovement = false
      self.disableAttacking = false
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
