local insert
insert = table.insert
local min, max
do
  local _obj_0 = math
  min, max = _obj_0.min, _obj_0.max
end
local random
random = love.math.random
local RoomRaw
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      self.adjacents = { }
      self.pos = Vector(x, y)
    end,
    __base = _base_0,
    __name = "RoomRaw"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  RoomRaw = _class_0
end
do
  local _class_0
  local generateRaw
  local _base_0 = {
    getChestRooms = function(self)
      local chestRooms = { }
      for _, room in pairs(self.rooms) do
        if room.adjacentsCount > 1 and room ~= self.currentRoom then
          insert(chestRooms, room)
        end
      end
      return chestRooms
    end,
    getStairRooms = function(self)
      local stairRooms = { }
      for _, room in pairs(self.rooms) do
        if room.adjacentsCount == 1 and room ~= self.currentRoom then
          insert(stairRooms, room)
        end
      end
      return stairRooms
    end,
    destruct = function(self)
      for _, room in pairs(self.rooms) do
        room:destruct()
      end
    end,
    draw = function(self)
      for _, room in pairs(self.rooms) do
        room:draw()
      end
    end,
    update = function(self, dt)
      self.currentRoom:update(dt)
      if self.currentRoom.cleared then
        self.currentRoom:openDoors()
        return self.prevRoom:openDoors()
      else
        self.currentRoom:closeDoors()
        return self.prevRoom:closeDoors()
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, roomsCount)
      self.roomsCount = roomsCount
      self.rooms = { }
      local roomsRaw = generateRaw(self)
      for k, roomRaw in pairs(roomsRaw) do
        self.rooms[k] = Room(roomRaw.pos.x, roomRaw.pos.y, roomRaw.adjacents)
      end
      self.currentRoom = randomChoice(self.rooms)
      self.currentRoom.cleared = true
      self.currentRoom:addEntity(Undead(self.currentRoom.center.x, self.currentRoom.center.y + 32))
      player:setPosition(self.currentRoom.center)
      self.prevRoom = self.currentRoom
      local chestChance = random()
      local chestCount
      if chestChance < 0.1 then
        chestCount = 2
      else
        chestCount = 1
      end
      for i = 1, chestCount do
        local chestRoom = randomChoice(self:getChestRooms())
        chestRoom:addEntity(Chest(chestRoom.center.x, chestRoom.center.y))
      end
      local stairRoom = randomChoice(self:getStairRooms())
      stairRoom.cleared = true
      return stairRoom:addEntity(Stairs(stairRoom.center.x, stairRoom.center.y))
    end,
    __base = _base_0,
    __name = "Dungeon"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  generateRaw = function(self)
    local n = 10
    local grid = { }
    local getFreeAdjacents
    getFreeAdjacents = function(x, y, free)
      if free == nil then
        free = 0
      end
      local adjacents = { }
      for i = max(1, y - 1), min(y + 1, n) do
        for j = max(1, x - 1), min(x + 1, n) do
          if not ((x == j and y == i) or (x ~= j and y ~= i) or grid[i][j] ~= free) then
            insert(adjacents, RoomRaw(j, i))
          end
        end
      end
      return adjacents
    end
    local getFreeAdjacentsCount
    getFreeAdjacentsCount = function(x, y, free)
      if free == nil then
        free = 0
      end
      local num = 0
      for i = max(1, y - 1), min(y + 1, n) do
        for j = max(1, x - 1), min(x + 1, n) do
          if not ((x == j and y == i) or (x ~= j and y ~= i) or grid[i][j] ~= free) then
            num = num + 1
          end
        end
      end
      return num
    end
    for i = 1, n do
      grid[i] = { }
      for j = 1, n do
        grid[i][j] = 0
      end
    end
    local x = random(2, n - 1)
    local y = random(2, n - 1)
    local rooms = {
      RoomRaw(x, y)
    }
    grid[y][x] = 1
    for i = 1, self.roomsCount - 1 do
      local possibilites = { }
      for _, room in pairs(rooms) do
        local adjacents = getFreeAdjacents(room.pos.x, room.pos.y)
        for _, adjacent in pairs(adjacents) do
          local count = getFreeAdjacentsCount(adjacent.pos.x, adjacent.pos.y)
          if count > 2 then
            table.insert(possibilites, adjacent)
          end
        end
      end
      if #possibilites == 0 then
        break
      end
      local room = randomChoice(possibilites)
      grid[room.pos.y][room.pos.x] = 1
      insert(rooms, room)
    end
    for _, room in pairs(rooms) do
      local adjacents = getFreeAdjacents(room.pos.x, room.pos.y, 1)
      for _, adjacent in pairs(adjacents) do
        local diff = adjacent.pos - room.pos
        local _exp_0 = diff
        if Vector.left == _exp_0 then
          insert(room.adjacents, "left")
        elseif Vector.right == _exp_0 then
          insert(room.adjacents, "right")
        elseif Vector.up == _exp_0 then
          insert(room.adjacents, "top")
        elseif Vector.down == _exp_0 then
          insert(room.adjacents, "bottom")
        end
      end
    end
    return rooms
  end
  Dungeon = _class_0
end
