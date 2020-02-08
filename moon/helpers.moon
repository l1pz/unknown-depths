import random from love.math

export *

Vector.left = Vector(-1, 0)
Vector.right = Vector(1, 0) 
Vector.up = Vector(0, -1)
Vector.down = Vector(0, 1)

nextDungeon = -> 
  player.disableMovement = true
  with camera
    \fade(0.5, {0, 0, 0, 1}, ->
      \setFollowLerp 1
      export dungeon = Dungeon #dungeon.rooms + random(2, 4)
      \fade(0.5, {0, 0, 0, 0}, ->
        \setFollowLerp 0.2
        player.disableMovement = false
      )
    )
  
  
  
