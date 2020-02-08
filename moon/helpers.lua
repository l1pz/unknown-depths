local random
random = love.math.random
Vector.left = Vector(-1, 0)
Vector.right = Vector(1, 0)
Vector.up = Vector(0, -1)
Vector.down = Vector(0, 1)
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
