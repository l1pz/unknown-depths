do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    checkCurrentRoom = function(self)
      if self.room:isInside(player.pos + player.offset) then
        dungeon.prevRoom = dungeon.currentRoom
        dungeon.currentRoom = self.room
      end
    end,
    open = function(self)
      self.closed = false
      return self:changeSprite(sprites.door[self.orientation .. "Open"])
    end,
    close = function(self)
      local items, len = world:queryRect(self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      for _, item in pairs(items) do
        if item.__class == Player then
          return 
        end
      end
      self.closed = true
      return self:changeSprite(sprites.door[self.orientation])
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y, orientation, room)
      self.orientation, self.room = orientation, room
      _class_0.__parent.__init(self, x, y, sprites.door[self.orientation .. "Open"])
      self.closed = false
      local items, len = world:queryRect(self.pos.x, self.pos.y, self.dim.x, self.dim.y)
      for _, item in pairs(items) do
        if item.__class == Wall then
          self.room:removeEntity(item)
        end
      end
    end,
    __base = _base_0,
    __name = "Door",
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
  Door = _class_0
end
