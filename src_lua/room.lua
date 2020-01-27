local insert
insert = table.insert
do
  local _class_0
  local _base_0 = {
    getPosition = function(self, x, y)
      return Vector(x, y) + self.pos
    end,
    placeWalls = function(self)
      local tileSize = tileSize
      local gameWidth = gameWidth
      local gameHeight = gameHeight
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
      self.walls[wall] = wall
    end,
    placeDoors = function(self, adjacents)
      if not (adjacents) then
        return 
      end
      local tileSize = tileSize
      local gameHeight = gameHeight
      for dir, room in pairs(adjacents) do
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
      end
    end,
    draw = function(self)
      for _, wall in pairs(self.walls) do
        wall:draw()
      end
      for _, doors in pairs(self.doors) do
        doors:draw()
      end
    end,
    update = function(self, dt) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, adjacents)
      self.pos = Vector(x * gameWidth, y * gameHeight)
      self.dim = Vector(gameWidth, gameHeight)
      self.center = self:getPosition(gameWidth / 2, gameHeight / 2)
      self.walls = { }
      self:placeWalls()
      self.doors = { }
      return self:placeDoors()
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