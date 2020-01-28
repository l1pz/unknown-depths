import insert from table
export class Room
  new: (x, y, adjacents) =>
    @pos = Vector x * gameWidth, y * gameHeight
    @dim = Vector gameWidth, gameHeight
    @center = @\getPosition gameWidth / 2, gameHeight / 2
    @wall = {}
    @\placeWalls!
    @door = {}
    @\placeDoors!
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
    pos = @\getPosition x, y
    wall = Wall pos.x, pos.y
    @walls[wall] = wall
  placeDoors: (adjacents) =>
    unless adjacents return
    for dir, room in pairs adjacents
      pos = switch dir
        when "top" @\getPosition gameWidth / 2 - tileSize, 0
        when "bottom" @\getPosition gameWidth / 2 - tileSize, gameHeight - tileSize
        when "right" @\getPosition gameWidth - tileSize, gameHeight / 2 - tileSize
        when "left" @\getPosition 0, gameHeight / 2 - tileSize
      door = Door pos.x, pos.y, dir, @
      @doors[door] = door
  draw: =>
    for _, wall in pairs(@walls)
      wall\draw!
    for _, door in pairs(@doors)
      door\draw!
  update: (dt) =>

    

      