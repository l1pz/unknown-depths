local insert
insert = table.insert
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
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
      return self:findPath()
    end,
    findPath = function(self)
      local map = copyGrid(dungeon.currentRoom.grid)
      local selfPosX, selfPosY = dungeon.currentRoom:getPosInGrid(self)
      map[selfPosY][selfPosX] = 0
      local grid = Grid(map)
      local pathfinder = Pathfinder(grid, "JPS", 0)
      local playerPosX, playerPosY = dungeon.currentRoom:getPosInGrid(player)
      local path = pathfinder:getPath(selfPosX, selfPosY, playerPosX, playerPosY)
      if path then
        self.nodes = { }
        for node, count in path:nodes() do
          insert(self.nodes, node)
        end
      end
    end,
    draw = function(self)
      if self.enableDraw then
        _class_0.__parent.__base.draw(self)
      end
      if debugDrawEnemyPath then
        local points = { }
        for i = 1, #self.nodes do
          local node = self.nodes[i]
          local x = dungeon.currentRoom.pos.x + (node.x - 1) * tileSize + tileSize / 2
          local y = dungeon.currentRoom.pos.y + (node.y - 1) * tileSize + tileSize / 2
          insert(points, x)
          insert(points, y)
        end
        return love.graphics.line(points)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y)
      _class_0.__parent.__init(self, x, y, sprites.undead)
      self.health = 5
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
