local gameplay = { }
local ui
local roomsCount = 5
gameplay.enter = function(self, previous)
  world = bump.newWorld()
  ui = UI(uiWidth, uiHeight)
  player = Player(0, 0)
  dungeon = Dungeon(roomsCount)
  local center = dungeon.currentRoom.center
  camera = Camera(center.x, center.y, gameWidth, gameHeight)
  fadeColor = {
    0,
    0,
    0,
    1
  }
  fadeIn()
  do
    camera:setFollowStyle("SCREEN_BY_SCREEN")
    camera:setFollowLerp(0.2)
    camera.scale = 1
  end
  debugDrawSprites = true
  debugDrawCollisionBoxes = false
  debugEnableShaders = true
  debugDrawPathGrid = false
  debugDrawEnemyPath = false
end
gameplay.update = function(self, dt)
  do
    local _with_0 = camera
    _with_0:update(dt)
    _with_0:follow(player.pos.x + player.offset.x, player.pos.y + player.offset.y)
  end
  input:update()
  tick.update(dt)
  flux.update(dt)
  dungeon:update(dt)
  return player:update(dt)
end
gameplay.leave = function(self, next) end
gameplay.draw = function(self)
  push:start()
  love.graphics.translate(0, uiHeight)
  camera:attach()
  dungeon:draw()
  player:draw()
  camera:detach()
  camera:draw()
  love.graphics.translate(0, -uiHeight)
  ui:draw()
  love.graphics.setColor(fadeColor)
  love.graphics.rectangle("fill", 0, 0, gameWidth, screenHeight)
  return push:finish()
end
gameplay.keypressed = function(self, key)
  local _exp_0 = key
  if "k" == _exp_0 then
    dungeon.currentRoom.cleared = true
  elseif "h" == _exp_0 then
    return manager:push(states.help)
  elseif "f" == _exp_0 then
    return push:switchFullscreen(windowedWidth, windowedHeight)
  elseif "g" == _exp_0 then
    return manager:enter(states.death)
  elseif "f1" == _exp_0 then
    debugDrawSprites = not debugDrawSprites
  elseif "f2" == _exp_0 then
    debugDrawCollisionBoxes = not debugDrawCollisionBoxes
  elseif "f3" == _exp_0 then
    debugEnableShaders = not debugEnableShaders
    return shaders:set(debugEnableShaders)
  elseif "f4" == _exp_0 then
    debugDrawPathGrid = not debugDrawPathGrid
  elseif "f5" == _exp_0 then
    debugDrawEnemyPath = not debugDrawEnemyPath
  elseif "f6" == _exp_0 then
    return nextDungeon()
  elseif "kp4" == _exp_0 then
    colorScheme = colorScheme + 1
    if colorScheme > #colorSchemes then
      colorScheme = 1
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "kp6" == _exp_0 then
    colorScheme = colorScheme - 1
    if colorScheme < 1 then
      colorScheme = #colorSchemes
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "escape" == _exp_0 then
    return manager:pop()
  elseif "kp+" == _exp_0 then
    camera.scale = camera.scale + 0.1
  elseif "kp-" == _exp_0 then
    camera.scale = camera.scale - 0.1
  end
end
return gameplay
