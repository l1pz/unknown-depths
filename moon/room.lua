local insert
insert = table.insert
do
  local _class_0
  local _base_0 = {
    destruct = function(self)
      for _, e in pairs(self.entities) do
        self:removeEntity(e)
      end
    end,
    getPosition = function(self, x, y)
      return Vector(x, y) + self.pos
    end,
    placeWalls = function(self)
      local hWallCount = gameWidth / tileSize - 1
      for i = 0, hWallCount do
        self:addWall(i * tileSize, 0)
        self:addWall(i * tileSize, gameHeight - tileSize)
      end
      local vWallCount = gameHeight / tileSize - 2
      for i = 1, vWallCount do
        self:addWall(0, i * tileSize)
        self:addWall(gameWidth - tileSize, i * tileSize)
      end
    end,
    addWall = function(self, x, y)
      local pos = self:getPosition(x, y)
      local wall = Wall(pos.x, pos.y)
      return self:addEntity(wall)
    end,
    placeDoors = function(self, adjacents)
      if not (adjacents) then
        return 
      end
      for _, dir in pairs(adjacents) do
        local pos
        local _exp_0 = dir
        if "top" == _exp_0 then
          pos = self:getPosition(gameWidth / 2 - tileSize, 0)
        elseif "bottom" == _exp_0 then
          pos = self:getPosition(gameWidth / 2 - tileSize, gameHeight - tileSize)
        elseif "right" == _exp_0 then
          pos = self:getPosition(gameWidth - tileSize, gameHeight / 2 - tileSize)
        elseif "left" == _exp_0 then
          pos = self:getPosition(0, gameHeight / 2 - tileSize)
        end
        local door = Door(pos.x, pos.y, dir, self)
        self.doors[door] = door
        self:addEntity(door)
      end
    end,
    openDoors = function(self)
      dungeon.prevRoom = dungeon.currentRoom
      for door in pairs(self.doors) do
        door:open()
      end
    end,
    closeDoors = function(self)
      for door in pairs(self.doors) do
        door:close()
      end
    end,
    addEntity = function(self, entity)
      self.entities[entity] = entity
    end,
    removeEntity = function(self, entity)
      world:remove(entity)
      self.entities[entity] = nil
    end,
    isInside = function(self, pos)
      return pos.x >= self.pos.x and pos.x <= self.pos.x + self.dim.x and pos.y >= self.pos.y and pos.y <= self.pos.y + self.dim.y
    end,
    isInsideCloseArea = function(self, pos)
      return pos.x >= self.pos.x + tileSize and pos.x <= self.pos.x + self.dim.x - tileSize and pos.y >= self.pos.y + tileSize and pos.y <= self.pos.y + self.dim.y - tileSize
    end,
    draw = function(self)
      for e in pairs(self.entities) do
        e:draw()
      end
    end,
    update = function(self, dt)
      for e in pairs(self.entities) do
        e:update(dt)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, adjacents)
      self.pos = Vector(x * gameWidth, y * gameHeight)
      self.dim = Vector(gameWidth, gameHeight)
      self.center = self:getPosition(gameWidth / 2, gameHeight / 2)
      self.entities = { }
      self.doors = { }
      self.cleared = false
      self.adjacentsCount = 0
      for _ in pairs(adjacents) do
        self.adjacentsCount = self.adjacentsCount + 1
      end
      self:placeWalls()
      return self:placeDoors(adjacents)
    end,
    __base = _base_0,
    __name = "Room"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Room = _class_0
end
