gameplay = {}

local ui

roomsCount = 5

gameplay.enter = (previous) =>
  -- set up the level
  export world = bump.newWorld!

  ui = UI uiWidth, uiHeight
  export player = Player 0, 0
  export dungeon = Dungeon roomsCount
  
  center = dungeon.currentRoom.center
  export camera = Camera center.x, center.y, gameWidth, gameHeight

  with camera
    \setFollowStyle "SCREEN_BY_SCREEN"
    \setFollowLerp 0.2
    .scale = 1
    .fade_color = {0,0,0,1}
    \fade 0.5, {0,0,0,0}

  export debugDrawSprites = true
  export debugDrawCollisionBoxes = false
  export debugEnableShaders = true
  export debugDrawPathGrid = false
  export debugDrawEnemyPath = false


gameplay.update = (dt) =>
  -- update entities
  with camera
    \update dt
    \follow player.pos.x + player.offset.x, player.pos.y + player.offset.y
  input\update!
  tick.update dt
  dungeon\update dt
  player\update dt

gameplay.leave = (next) =>
  -- destroy entities and cleanup resources
  dungeon\destruct!
  for item in *world\getItems!
    world\remove item
  player = nil
  camera = nil
  ui = nil

gameplay.draw = () =>
  -- draw the level
  push\start!
  love.graphics.translate 0, uiHeight
  camera\attach!
  dungeon\draw!
  player\draw!
  camera\detach!
  camera\draw!
  love.graphics.translate 0, -uiHeight
  ui\draw!
  push\finish!
  

gameplay.keypressed = (key) =>
  switch key
    when "k" then dungeon.currentRoom.cleared = true
    when "h" then manager\push states.help
    when "f"
      push\switchFullscreen(windowedWidth, windowedHeight)
    when "f1" then export debugDrawSprites = not debugDrawSprites
    when "f2" then export debugDrawCollisionBoxes = not debugDrawCollisionBoxes
    when "f3" 
      export debugEnableShaders = not debugEnableShaders
      shaders\set debugEnableShaders
    when "f4" then export debugDrawPathGrid = not debugDrawPathGrid
    when "f5" then export debugDrawEnemyPath = not debugDrawEnemyPath
    when "kp4"
      export colorScheme = colorScheme + 1
      if colorScheme > #colorSchemes then colorScheme = 1
      export colors = colorSchemes[colorScheme]
      sprites\refreshColors!
    when "kp6"
      export colorScheme = colorScheme - 1
      if colorScheme < 1 then colorScheme = #colorSchemes
      export colors = colorSchemes[colorScheme]
      sprites\refreshColors!
    when "f3"
      nextDungeon!
    when "escape" 
      manager\pop! 
    when "kp+" camera.scale += 0.1
    when "kp-" camera.scale -= 0.1

return gameplay