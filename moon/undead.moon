import insert from table

export class Undead extends Entity
  new: (x, y) =>
    super x, y, sprites.undead
    @health = 5
    @enableDraw = true
    @dir = Vector!
    @nodes = {}

  damage: (d) =>
    @health -= d
    @enableDraw = false
    fn = -> @enableDraw = true
    tick.delay(fn, @, 0.02)
    if @health == 0
      dungeon.currentRoom\removeEntity @

  update: (dt) =>
    @findPath!
    --print @dir
    --@move @dir * 10 * dt

  findPath: =>
    -- Creates a grid object
    map = copyGrid dungeon.currentRoom.grid
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid @
    map[selfPosY][selfPosX] = 0
    grid = Grid map 
    -- Creates a pathfinder object using Jump Point Search
    pathfinder = Pathfinder grid, "JPS", 0

    -- Define start and goal locations coordinates
    playerPosX, playerPosY = dungeon.currentRoom\getPosInGrid player

    -- Calculates the path, and its length
    path = pathfinder\getPath(selfPosX, selfPosY, playerPosX, playerPosY)
    if path
      @nodes = {}
      for node, count in path\nodes!
        insert @nodes, node
      --print node.x, node.y
      --goalPos = Vector dungeon.currentRoom.pos.x + node.x * tileSize, dungeon.currentRoom.pos.y + node.y * tileSize
      --print goalPos
      --print @pos
      --@dir = goalPos - @pos
        

  draw: =>
    if @enableDraw then super!
    if debugDrawEnemyPath
      points = {}
      for i = 1, #@nodes
        node = @nodes[i]
        x = dungeon.currentRoom.pos.x + (node.x - 1) * tileSize + tileSize / 2
        y = dungeon.currentRoom.pos.y + (node.y - 1) * tileSize + tileSize / 2
        insert points, x
        insert points, y
      love.graphics.line points