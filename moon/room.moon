import insert from table
export class Room
  new: (x, y, adjacents) =>
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
        else
          return true
      
    @grid = {}
    for y = 1, @dim.y/tileSize
      @grid[y] = { }
      for x = 1, @dim.x/tileSize 
        @grid[y][x] = false

    @adjacentsCount = 0 
    for _ in pairs adjacents
      @adjacentsCount += 1

    @placeWalls!
    @placeDoors adjacents
  
  destruct: =>
    for _, e in pairs @entities
      @removeEntity e

  getPosition: (x, y) =>
    return Vector(x, y) + @pos

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
          if @grid[ty][tx]
            love.graphics.setColor 1, 0, 0, 0.4
            love.graphics.rectangle "fill", x, y, tileSize, tileSize

  update: (dt) =>
    for e in pairs(@entities)
      e\update dt
    @updateGrid!

  updateGrid: =>
    for y = @pos.y, @pos.y + @dim.y - tileSize, tileSize
      for x = @pos.x, @pos.x + @dim.x - tileSize, tileSize
        tx, ty = (x - @pos.x) / tileSize + 1, (y - @pos.y) / tileSize + 1
        @grid[ty][tx] = false
        items, len = world\queryRect x, y, tileSize, tileSize, @gridFilter 
        if len > 0 then @grid[ty][tx] = true
      