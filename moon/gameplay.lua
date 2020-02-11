local gameplay = { }
local ui
local roomsCount = 5
gameplay.enter = function(self, previous)
  love.graphics.setFont(fontGameplay)
  world = bump.newWorld()
  ui = UI(uiWidth, uiHeight)
  player = Player(0, 0)
  dungeon = Dungeon(roomsCount)
  local center = dungeon.currentRoom.center
  camera = Camera(center.x, center.y, gameWidth, gameHeight)
  do
    camera:setFollowStyle("SCREEN_BY_SCREEN")
    camera:setFollowLerp(0.2)
    camera.scale = 1
  end
  debugDrawSprites = true
  debugDrawCollisionBoxes = false
end
gameplay.update = function(self, dt)
  do
    local _with_0 = camera
    _with_0:update(dt)
    _with_0:follow(player.pos.x + player.offset.x, player.pos.y + player.offset.y)
  end
  input:update()
  dungeon:update(dt)
  return player:update(dt)
end
gameplay.leave = function(self, next)
  dungeon.destruct()
  local _list_0 = world:getItems()
  for _index_0 = 1, #_list_0 do
    local item = _list_0[_index_0]
    world:remove(item)
  end
  local player = nil
  local camera = nil
  ui = nil
end
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
  return push:finish()
end
gameplay.keypressed = function(self, key)
  local _exp_0 = key
  if "f1" == _exp_0 then
    local debugDrawSprites = not debugDrawSprites
  elseif "f2" == _exp_0 then
    local debugDrawCollisionBoxes = not debugDrawCollisionBoxes
  elseif "right" == _exp_0 then
    colorScheme = colorScheme + 1
    if colorScheme > #colorSchemes then
      colorScheme = 1
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "left" == _exp_0 then
    colorScheme = colorScheme - 1
    if colorScheme < 1 then
      colorScheme = #colorSchemes
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "f3" == _exp_0 then
    return nextDungeon()
  elseif "escape" == _exp_0 then
    return love.event.quit()
  elseif "kp+" == _exp_0 then
    camera.scale = camera.scale + 0.1
  elseif "kp-" == _exp_0 then
    camera.scale = camera.scale - 0.1
  end
end
return gameplay
