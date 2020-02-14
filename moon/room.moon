import insert from table
import floor from math
import random from love.math
export class Room
  new: (x, y, adjacents, starting = false) =>
    @pos = Vector x * gameWidth, y * gameHeight
    @dim = Vector gameWidth, gameHeight
    @center = @getPosition gameWidth / 2, gameHeight / 2
    @entities = {}
    @doors = {}
    @cleared = false
    @occupied = false
    @doorsOpen = false
    @gridFilter = (item) -> 
      --print item
      switch item.__class
        when Arrow
          return false
        when Player
          return false
        else
          return true
      
    @grid = {}
    for y = 1, @dim.y/tileSize
      @grid[y] = { }
      for x = 1, @dim.x/tileSize 
        @grid[y][x] = 0

    @adjacentsCount = 0 
    for _ in pairs adjacents
      @adjacentsCount += 1

    @placeWalls!
    @placeDoors adjacents
    @enemyCount = random 1, 4
    unless starting
      @placeEnemies @enemyCount
  
  destruct: =>
    for _, e in pairs @entities
      @removeEntity e

  getPosition: (x, y) =>
    return Vector(x, y) + @pos

  placeEnemies: (n) =>
    count = 0
    while count < n
      x = random(tileSize * 3, gameWidth - 4 * tileSize) + @pos.x
      y = random(tileSize * 3, gameHeight - 4 * tileSize) + @pos.y
      items, len  = world\queryRect x, y, sprites.undead.width, sprites.undead.height
      if len == 0
        @addEntity Undead x, y
        count += 1

  placeWalls: =>
    hWallCount = gameWidth / tileSize - 1
    for i = 0, hWallCount
      @addWall i * tileSize, 0
      @addWall i * tileSize, gameHeight - tileSize
    vWallCount = gameHeight / tileSize - 2
    for i = 1, vWallCount
      @addWall 0, i * tileSize
      @addWall gameWidth - tileSize, i * tileSize

  addWall: (x, y)=>
    pos = @getPosition x, y
    wall = Wall pos.x, pos.y
    @addEntity wall

  placeDoors: (adjacents) =>
    unless adjacents return
    for _, dir in pairs adjacents
      pos = switch dir
        when "top" @getPosition gameWidth / 2 - tileSize, 0
        when "bottom" @getPosition gameWidth / 2 - tileSize, gameHeight - tileSize
        when "right" @getPosition gameWidth - tileSize, gameHeight / 2 - tileSize
        when "left" @getPosition 0, gameHeight / 2 - tileSize
      door = Door pos.x, pos.y, dir, @
      @doors[door] = door
      @addEntity door

  openDoors: =>
    @doorsOpen = true
    for door in pairs(@doors)
      door\open!

  closeDoors: =>
    @doorsOpen = false
    for door in pairs(@doors)
      door\close!

  addEntity: (entity) =>
    @entities[entity] = entity

  removeEntity: (entity) =>
    world\remove entity
    @entities[entity] = nil

  isInside: (pos) =>
    return pos.x >= @pos.x and pos.x <= @pos.x + @dim.x and pos.y >= @pos.y and pos.y <= @pos.y + @dim.y

  isInsideCloseArea: (pos) =>
    return pos.x >= @pos.x + tileSize and pos.x <= @pos.x + @dim.x - tileSize and pos.y >= @pos.y + tileSize and pos.y <= @pos.y + @dim.y - tileSize

  draw: =>
    for e in pairs(@entities)
      e\draw!
    if debugDrawPathGrid
      for y = @pos.y, @pos.y + @dim.y - tileSize, tileSize
        for x = @pos.x, @pos.x + @dim.x - tileSize, tileSize
          tx, ty = (x - @pos.x) / tileSize + 1, (y - @pos.y) / tileSize + 1
          if @grid[ty][tx] == 1
            love.graphics.setColor 1, 0, 0, 0.4
          else 
            love.graphics.setColor 0, 0, 1, 0.4
          love.graphics.rectangle "fill", x, y, tileSize, tileSize

  removeEnemies: =>
    for e in pairs(@entities)
      if e.__class == Undead
       @removeEntity e
    

  update: (dt) =>
    if @enemyCount == 0
      @cleared = true
    @updateGrid!
    for e in pairs(@entities)
      e\update dt
  
  updateGrid: =>
    for y = @pos.y, @pos.y + @dim.y - tileSize, tileSize
      for x = @pos.x, @pos.x + @dim.x - tileSize, tileSize
        tx, ty = (x - @pos.x) / tileSize + 1, (y - @pos.y) / tileSize + 1
        @grid[ty][tx] = 0
        items, len = world\queryRect x, y, tileSize, tileSize, @gridFilter 
        if len > 0 then @grid[ty][tx] = 1

  getPosInGrid: (pos, offset = Vector!) =>
    pos = (pos + offset - @pos) / tileSize
    return floor(pos.x) + 1, floor(pos.y) + 1
      