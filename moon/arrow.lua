do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    onCollision = function(self, cols)
      for _index_0 = 1, #cols do
        local col = cols[_index_0]
        local other = col.other
        local color = other.sprite.color
        local _exp_0 = other.__class
        if Undead == _exp_0 then
          other:damage(self.damage)
        end
        if not (other.__class == Arrow) then
          self:destroy(color)
        end
      end
    end,
    update = function(self, dt)
      if not (self.stuck) then
        return self:move(self.dir * self.speed * dt)
      end
    end,
    destroy = function(self, color)
      do
        local _with_0 = player.weapon.psystem
        _with_0:setDirection((self.dir * -1).angle)
        _with_0:setPosition(self.pos.x, self.pos.y)
        _with_0:setColors(color[1], color[2], color[3], 1)
        _with_0:emit(3)
      end
      return dungeon.currentRoom:removeEntity(self)
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
      self.damage = 1
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Arrow = _class_0
end
