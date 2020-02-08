import insert from table
export class Room
  new: (x, y, adjacents) =>
    @pos = Vector x * gameWidth, y * gameHeight
    @dim = Vector gameWidth, gameHeight
    @center = @getPosition gameWidth / 2, gameHeight / 2
    @entities = {}

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
      @addEntity door

  addEntity: (entity) =>
    @entities[entity] = entity

  removeEntity: (entity) =>
    world\remove entity
    @entities[entity] = nil

  isInside: (pos) =>
    if pos.x >= @pos.x and pos.x <= @pos.x + @dim.x and pos.y >= @pos.y and pos.y <= @pos.y + @dim.y
      return true
    return false

  draw: =>
    for _, e in pairs(@entities)
      e\draw!

  update: (dt) =>
    for _, e in pairs(@entities)
      e\update!

    

      