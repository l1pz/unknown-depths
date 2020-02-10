gameplay = {}

local ui

roomsCount = 5

gameplay.enter = (previous) =>
  -- set up the level
  love.graphics.setFont fontGameplay

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

  export debugDrawSprites = true
  export debugDrawCollisionBoxes = false


gameplay.update = (dt) =>
  -- update entities
  with camera
    \update dt
    \follow player.pos.x + player.offset.x, player.pos.y + player.offset.y
  input\update!
  dungeon\update dt
  player\update dt

gameplay.leave = (next) =>
  -- destroy entities and cleanup resources
  dungeon.destruct!
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
    when "f1" then debugDrawSprites = not debugDrawSprites
    when "f2" then debugDrawCollisionBoxes = not debugDrawCollisionBoxes
    when "right"
      colorScheme+=1
      if colorScheme > #colorSchemes then colorScheme = 1
      colors = colorSchemes[colorScheme]
      sprites\refreshColors!
    when "left"
      colorScheme-=1
      if colorScheme < 1 then colorScheme = #colorSchemes
      colors = colorSchemes[colorScheme]
      sprites\refreshColors!
    when "f3"
      nextDungeon!
    when "escape" love.event.quit!
    when "kp+" camera.scale += 0.1
    when "kp-" camera.scale -= 0.1

return gameplay