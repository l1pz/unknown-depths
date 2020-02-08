local insert
insert = table.insert
local min, max
do
  local _obj_0 = math
  min, max = _obj_0.min, _obj_0.max
end
local random
random = love.math.random
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
  local index = keys[random(1, #keys)]
  return t[index]
end
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
        self.rooms[k] = Room(roomRaw.pos.x, roomRaw.pos.y, roomRaw.adjacents)
      end
      self.currentRoom = randomChoice(self.rooms)
      self.currentRoom:addEntity(Chest(self.currentRoom.center.x - 8, self.currentRoom.center.y - 28))
      return player:setPosition(self.currentRoom.center)
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
    for i = 1, self.roomsCount do
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
