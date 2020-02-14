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
      elseif Undead == _exp_0 then
        return "slide"
      end
    end,
    update = function(self, dt)
      local ix, iy = input:get("move")
      self.movementDir = Vector(ix, iy)
      local velocity = self.movementDir * self.speed * dt
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
      return self.weapon:update(dt)
    end,
    damage = function(self)
      if not (self.invulnurable) then
        self.health = self.health - 1
        self.invulnurable = true
        local fn
        fn = function()
          self.invulnurable = false
        end
        return tick.delay(fn, self, 2)
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.weapon:draw()
    end,
    onCollision = function(self, cols)
      for _index_0 = 1, #cols do
        local col = cols[_index_0]
        local other = col.other
        local _exp_0 = other.__class
        if Door == _exp_0 then
          other:checkCurrentRoom()
        elseif Chest == _exp_0 then
          other:open()
        elseif Stairs == _exp_0 then
          nextDungeon()
        elseif Undead == _exp_0 then
          self:damage()
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
      self.movementDir = Vector()
      self.health = 6
      self.gold = 0
      self.keys = 0
      self.bombs = 0
      self.weapon = Bow()
      self.spell = nil
      self.disableMovement = false
      self.disableAttacking = false
      self.invulnurable = false
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
