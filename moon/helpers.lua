local random
random = love.math.random
Vector.left = Vector(-1, 0)
Vector.right = Vector(1, 0)
Vector.up = Vector(0, -1)
Vector.down = Vector(0, 1)
randomChoice = function(t)
  local keys
  do
    local _accum_0 = { }
    local _len_0 = 1
    for key, _ in pairs(t) do
      _accum_0[_len_0] = key
      _len_0 = _len_0 + 1
    end
    keys = _accum_0
  end
  local index = keys[random(1, #keys)]
  return t[index]
end
copyGrid = function(t)
  local n = { }
  for y = 1, #t do
    n[y] = { }
    for x = 1, #t[y] do
      n[y][x] = t[y][x]
    end
  end
  return n
end
fadeIn = function(fn)
  if fn == nil then
    fn = function() end
  end
  print("fadeIn")
  fadeColor = {
    0,
    0,
    0,
    1
  }
  return flux.to(fadeColor, 0.5, {
    [4] = 0
  }):oncomplete(fn)
end
fadeOut = function(fn)
  if fn == nil then
    fn = function() end
  end
  fadeColor = {
    0,
    0,
    0,
    0
  }
  return flux.to(fadeColor, 0.5, {
    [4] = 1
  }):oncomplete(fn)
end
nextDungeon = function()
  depth = depth + 1
  player.disableMovement = true
  camera:setFollowLerp(1)
  return fadeOut(function()
    colors = randomChoice(colorSchemes)
    sprites:refreshColors()
    dungeon:destruct()
    dungeon = Dungeon(#dungeon.rooms + random(2, 4))
    return fadeIn(function()
      camera:setFollowLerp(0.2)
      player.disableMovement = false
    end)
  end)
end
