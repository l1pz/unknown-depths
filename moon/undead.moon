import insert from table

export class Undead extends Entity
  new: (x, y) =>
    super x, y, sprites.undead
    @health = 5
    @speed = 25
    @enableDraw = true
    @dir = Vector!
    @nodes = {}

  filter: (item, other) ->
    switch other.__class
      when Wall then "slide"
      when Chest then "slide"
      when Stairs then "cross"
      when Door then "slide" 
      when Undead then "slide"
      when Player return "slide"

  damage: (d) =>
    @health -= d
    @enableDraw = false
    fn = -> @enableDraw = true
    tick.delay(fn, @, 0.02)
    if @health == 0
      dungeon.currentRoom\removeEntity @

  update: (dt) =>
    @findPath!
    @move @dir * @speed * dt

  clearSelfGrid: (map) =>
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid @pos
    map[selfPosY][selfPosX] = 0
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid Vector(@pos.x + @dim.x, @pos.y)
    map[selfPosY][selfPosX] = 0
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid Vector(@pos.x, @pos.y + @dim.y)
    map[selfPosY][selfPosX] = 0
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid Vector(@pos.x + @dim.x, @pos.y + @dim.y)
    map[selfPosY][selfPosX] = 0

  findPath: =>
    -- Creates a grid object
    map = copyGrid dungeon.currentRoom.grid
    selfPosX, selfPosY = dungeon.currentRoom\getPosInGrid @pos
    @clearSelfGrid map

    grid = Grid map 
    -- Creates a pathfinder object using Jump Point Search
    pathfinder = Pathfinder grid, "ASTAR", 0

    -- Define start and goal locations coordinates
    playerPosX, playerPosY = dungeon.currentRoom\getPosInGrid player.pos

    -- Calculates the path, and its length
    path = pathfinder\getPath(selfPosX, selfPosY, playerPosX, playerPosY)
    if path
      @nodes = {}
      for node, count in path\nodes!
        px = dungeon.currentRoom.pos.x + (node.x - 1) * tileSize + tileSize / 2
        py = dungeon.currentRoom.pos.y + (node.y - 1) * tileSize + tileSize / 2
        pos = Vector(px, py)
        insert @nodes, pos
      if #@nodes > 1
        @dir = (@nodes[2] - @pos).normalized
        

  draw: =>
    if @enableDraw then super!
    if debugDrawEnemyPath
      points = {}
      if #@nodes > 2
        for node in *@nodes
          insert points, node.x
          insert points, node.y
        love.graphics.line points
      --for node in *@nodes
        --love.graphics.setColor(1, 0, 0, 1)
        --love.graphics.points(node.x, node.y)