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
nextDungeon = function()
  player.disableMovement = true
  do
    camera:fade(0.5, {
      0,
      0,
      0,
      1
    }, function()
      camera:setFollowLerp(1)
      colors = randomChoice(colorSchemes)
      sprites:refreshColors()
      dungeon:destruct()
      dungeon = Dungeon(#dungeon.rooms + random(2, 4))
      return camera:fade(0.5, {
        0,
        0,
        0,
        0
      }, function()
        camera:setFollowLerp(0.2)
        player.disableMovement = false
      end)
    end)
    return camera
  end
end
