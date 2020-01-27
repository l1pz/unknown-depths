import insert from table
import random, min, max from math

randomChoice = (t) ->
  keys = [key for key, _ in pairs t]
  index = keys[random(1, #keys)]
  return t[index]

class RoomRaw
  new: (@x, @y) =>
    @adjacents = {}

export class Dungeon
  new: (@roomsCount) =>
    @rooms = {}
    roomsRaw = generateRaw @
    for k, roomRaw in pairs roomsRaw
      @rooms[k] = Room roomRaw.x, roomRaw.y, roomRaw.adjacents
    @currentRoom = randomChoice @rooms
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
        adjacents = getFreeAdjacents room.x, room.y
        for _, adjacent in pairs adjacents
          count = getFreeAdjacentsCount adjacent.x, adjacent.y
          if count > 2
            table.insert possibilites, adjacent
      break if #possibilites == 0
      room = randomChoice possibilites
      grid[room.y][room.x] = 1
      insert rooms, room
    for _, room in pairs rooms 
      adjacents = getFreeAdjacents room.x, room.y, 1
      for _, adjacent in pairs adjacents
        dx = adjacent.x - room.x
        dy = adjacent.y - room.y
        switch {dx, dy}
          when {-1, 0} insert room.adjacents "left"
          when {1, 0} insert room.adjacents "right"
          when {0, -1} insert room.adjacents "top"
          when {0, 1} insert room.adjacents "bottom"
    return rooms