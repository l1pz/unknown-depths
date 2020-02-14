local insert
insert = table.insert
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
        return "slide"
      elseif Undead == _exp_0 then
        return "slide"
      elseif Player == _exp_0 then
        return "slide"
      end
    end,
    damage = function(self, d)
      self.health = self.health - d
      self.enableDraw = false
      local fn
      fn = function()
        self.enableDraw = true
      end
      tick.delay(fn, self, 0.02)
      if self.health == 0 then
        return dungeon.currentRoom:removeEntity(self)
      end
    end,
    update = function(self, dt)
      self:findPath()
      return self:move(self.dir * self.speed * dt)
    end,
    clearSelfGrid = function(self, map)
      local selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(self.pos)
      map[selfPosY][selfPosX] = 0
      selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(Vector(self.pos.x + self.dim.x, self.pos.y))
      map[selfPosY][selfPosX] = 0
      selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(Vector(self.pos.x, self.pos.y + self.dim.y))
      map[selfPosY][selfPosX] = 0
      selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(Vector(self.pos.x + self.dim.x, self.pos.y + self.dim.y))
      map[selfPosY][selfPosX] = 0
    end,
    findPath = function(self)
      local map = copyGrid(dungeon.currentRoom.grid)
      local selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(self.pos)
      self:clearSelfGrid(map)
      local grid = Grid(map)
      local pathfinder = Pathfinder(grid, "ASTAR", 0)
      local playerPosX, playerPosY = dungeon.currentRoom:getPosInGrid(player.pos)
      local path = pathfinder:getPath(selfPosX, selfPosY, playerPosX, playerPosY)
      if path then
        self.nodes = { }
        for node, count in path:nodes() do
          local px = dungeon.currentRoom.pos.x + (node.x - 1) * tileSize + tileSize / 2
          local py = dungeon.currentRoom.pos.y + (node.y - 1) * tileSize + tileSize / 2
          local pos = Vector(px, py)
          insert(self.nodes, pos)
        end
        if #self.nodes > 1 then
          self.dir = (self.nodes[2] - self.pos).normalized
        end
      end
    end,
    draw = function(self)
      if self.enableDraw then
        _class_0.__parent.__base.draw(self)
      end
      if debugDrawEnemyPath then
        local points = { }
        if #self.nodes > 2 then
          local _list_0 = self.nodes
          for _index_0 = 1, #_list_0 do
            local node = _list_0[_index_0]
            insert(points, node.x)
            insert(points, node.y)
          end
          return love.graphics.line(points)
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y)
      _class_0.__parent.__init(self, x, y, sprites.undead)
      self.health = 5
      self.speed = 25
      self.enableDraw = true
      self.dir = Vector()
      self.nodes = { }
    end,
    __base = _base_0,
    __name = "Undead",
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
  Undead = _class_0
end
