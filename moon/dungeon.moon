import insert from table
import min, max from math
import random from love.math

randomChoice = (t) ->
  keys = [key for key, _ in pairs t]
  index = keys[random(1, #keys)]
  return t[index]

class RoomRaw
  new: (x, y) =>
    @adjacents = {}
    @pos = Vector x, y

export class Dungeon
  new: (@roomsCount) =>
    @rooms = {}
    roomsRaw = generateRaw @
    for k, roomRaw in pairs roomsRaw
      @rooms[k] = Room roomRaw.pos.x, roomRaw.pos.y, roomRaw.adjacents
    @currentRoom = randomChoice @rooms
    @currentRoom\addEntity Chest(@currentRoom.center.x - 8, @currentRoom.center.y - 28)
    player\setPosition @currentRoom.center
  draw: =>
    for _, room in pairs @rooms
      room\draw!
  update: (dt) =>
    @currentRoom\update dt
  generateRaw = =>
    n = 10
    grid = {}
    getFreeAdjacents = (x, y, free = 0) ->
      adjacents = {}
      for i = max(1, y - 1), min(y + 1, n)
        for j = max(1, x - 1), min(x + 1, n)
          unless (x == j and y == i) or (x != j and y != i) or grid[i][j] != free 
            insert adjacents, RoomRaw(j, i)
      return adjacents
    getFreeAdjacentsCount = (x, y, free = 0) ->
      num = 0
      for i = max(1, y - 1), min(y + 1, n)
        for j = max(1, x - 1), min(x + 1, n)
          unless (x == j and y == i) or (x != j and y != i) or grid[i][j] != free 
            num += 1
      return num
    for i = 1, n 
      grid[i] = { }
      for j = 1, n 
        grid[i][j] = 0
    x = random 2, n - 1
    y = random 2, n - 1
    rooms = { RoomRaw(x, y) }
    grid[y][x] = 1
    for i = 1, @roomsCount
      possibilites = {}
      for _, room in pairs rooms
        adjacents = getFreeAdjacents room.pos.x, room.pos.y
        for _, adjacent in pairs adjacents
          count = getFreeAdjacentsCount adjacent.pos.x, adjacent.pos.y
          if count > 2
            table.insert possibilites, adjacent
      break if #possibilites == 0
      room = randomChoice possibilites
      grid[room.pos.y][room.pos.x] = 1
      insert rooms, room
    for _, room in pairs rooms 
      adjacents = getFreeAdjacents room.pos.x, room.pos.y, 1
      for _, adjacent in pairs adjacents
        diff = adjacent.pos - room.pos
        switch diff
          when Vector.left
            insert room.adjacents, "left"
          when Vector.right
            insert room.adjacents, "right"
          when Vector.up
            insert room.adjacents, "top"
          when Vector.down
            insert room.adjacents, "bottom"
    return rooms