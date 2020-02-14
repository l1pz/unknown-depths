local insert
insert = table.insert
local floor
floor = math.floor
local random
random = love.math.random
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
    placeEnemies = function(self, n)
      local count = 0
      while count < n do
        local x = random(tileSize, gameWidth - 2 * tileSize) + self.pos.x
        local y = random(tileSize, gameHeight - 2 * tileSize) + self.pos.y
        local items, len = world:queryRect(x, y, sprites.undead.width, sprites.undead.height)
        if len == 0 then
          self:addEntity(Undead(x, y))
          count = count + 1
        end
      end
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
      self.doorsOpen = true
      for door in pairs(self.doors) do
        door:open()
      end
    end,
    closeDoors = function(self)
      self.doorsOpen = false
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
      if debugDrawPathGrid then
        for y = self.pos.y, self.pos.y + self.dim.y - tileSize, tileSize do
          for x = self.pos.x, self.pos.x + self.dim.x - tileSize, tileSize do
            local tx, ty = (x - self.pos.x) / tileSize + 1, (y - self.pos.y) / tileSize + 1
            if self.grid[ty][tx] == 1 then
              love.graphics.setColor(1, 0, 0, 0.4)
            else
              love.graphics.setColor(0, 0, 1, 0.4)
            end
            love.graphics.rectangle("fill", x, y, tileSize, tileSize)
          end
        end
      end
    end,
    removeEnemies = function(self)
      for e in pairs(self.entities) do
        if e.__class == Undead then
          self:removeEntity(e)
        end
      end
    end,
    update = function(self, dt)
      if self.enemyCount == 0 then
        self.cleared = true
      end
      self:updateGrid()
      for e in pairs(self.entities) do
        e:update(dt)
      end
    end,
    updateGrid = function(self)
      for y = self.pos.y, self.pos.y + self.dim.y - tileSize, tileSize do
        for x = self.pos.x, self.pos.x + self.dim.x - tileSize, tileSize do
          local tx, ty = (x - self.pos.x) / tileSize + 1, (y - self.pos.y) / tileSize + 1
          self.grid[ty][tx] = 0
          local items, len = world:queryRect(x, y, tileSize, tileSize, self.gridFilter)
          if len > 0 then
            self.grid[ty][tx] = 1
          end
        end
      end
    end,
    getPosInGrid = function(self, pos, offset)
      if offset == nil then
        offset = Vector()
      end
      pos = (pos + offset - self.pos) / tileSize
      return floor(pos.x) + 1, floor(pos.y) + 1
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, adjacents, starting)
      if starting == nil then
        starting = false
      end
      self.pos = Vector(x * gameWidth, y * gameHeight)
      self.dim = Vector(gameWidth, gameHeight)
      self.center = self:getPosition(gameWidth / 2, gameHeight / 2)
      self.entities = { }
      self.doors = { }
      self.cleared = false
      self.occupied = false
      self.doorsOpen = false
      self.gridFilter = function(item)
        local _exp_0 = item.__class
        if Arrow == _exp_0 then
          return false
        elseif Player == _exp_0 then
          return false
        else
          return true
        end
      end
      self.grid = { }
      for y = 1, self.dim.y / tileSize do
        self.grid[y] = { }
        for x = 1, self.dim.x / tileSize do
          self.grid[y][x] = 0
        end
      end
      self.adjacentsCount = 0
      for _ in pairs(adjacents) do
        self.adjacentsCount = self.adjacentsCount + 1
      end
      self:placeWalls()
      self:placeDoors(adjacents)
      self.enemyCount = random(1, 4)
      if not (starting) then
        return self:placeEnemies(self.enemyCount)
      end
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
