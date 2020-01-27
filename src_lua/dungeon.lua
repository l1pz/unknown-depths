local insert
insert = table.insert
local randomChoice
randomChoice = function(t)
  local keys
  do
    local _accum_0 = { }
    local _len_0 = 1
    for key, _ in pairs(t) do
      _accum_0[_len_0] = key
      _len_0 = _len_0 + 1
    end
    keys = _accum_0
  end
  local index = keys[math.random(1, #keys)]
  return t[index]
end
local RoomRaw
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      self.x, self.y = x, y
      self.adjacents = { }
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
    draw = function(self)
      for _, room in pairs(self.rooms) do
        room:draw()
      end
    end,
    update = function(self, dt)
      return self.currentRoom:update(dt)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, roomsCount)
      self.roomsCount = roomsCount
      self.rooms = { }
      local roomsRaw = generateRaw(self)
      for k, roomRaw in pairs(roomsRaw) do
        self.rooms[k] = Room(roomRaw.x, roomRaw.y, roomRaw.adjacents)
      end
      self.currentRoom = randomChoice(self.rooms)
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
      for i = math.max(1, y - 1), math.min(y + 1, n) do
        for j = math.max(1, x - 1), math.min(x + 1, n) do
          if not ((x == j and y == i) or (x ~= j and y ~= i) or grid[i][j] ~= free) then
            table.insert(adjacents, RoomRaw(j, i))
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
      for i = math.max(1, y - 1), math.min(y + 1, n) do
        for j = math.max(1, x - 1), math.min(x + 1, n) do
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
    local x = math.random(2, n - 1)
    local y = math.random(2, n - 1)
    local rooms = {
      RoomRaw(x, y)
    }
    grid[y][x] = 1
    for i = 1, self.roomsCount do
      local possibilites = { }
      for _, room in pairs(rooms) do
        local adjacents = getFreeAdjacents(room.x, room.y)
        for _, adjacent in pairs(adjacents) do
          local count = getFreeAdjacentsCount(adjacent.x, adjacent.y)
          if count > 2 then
            table.insert(possibilites, adjacent)
          end
        end
      end
      if #possibilites == 0 then
        break
      end
      local room = randomChoice(possibilites)
      grid[room.y][room.x] = 1
      table.insert(rooms, room)
    end
    for _, room in pairs(rooms) do
      local adjacents = getFreeAdjacents(room.x, room.y, 1)
      for _, adjacent in pairs(adjacents) do
        local dx = adjacent.x - room.x
        local dy = adjacent.y - room.y
        local _exp_0 = {
          dx,
          dy
        }
        if {
          -1,
          0
        } == _exp_0 then
          table.insert(room.adjacents("left"))
        elseif {
          1,
          0
        } == _exp_0 then
          table.insert(room.adjacents("right"))
        elseif {
          0,
          -1
        } == _exp_0 then
          table.insert(room.adjacents("top"))
        elseif {
          0,
          1
        } == _exp_0 then
          table.insert(room.adjacents("bottom"))
        end
      end
    end
    return rooms
  end
  Dungeon = _class_0
end
