import random from love.math

export *

Vector.left = Vector(-1, 0)
Vector.right = Vector(1, 0) 
Vector.up = Vector(0, -1)
Vector.down = Vector(0, 1)

randomChoice = (t) ->
  keys = [key for key, _ in pairs t]
  index = keys[random(1, #keys)]
  return t[index]

copyGrid = (t) ->
  n = {}
  for y = 1, #t
    n[y] = {}
    for x = 1, #t[y]
      n[y][x] = t[y][x]
  return n

nextDungeon = -> 
  player.disableMovement = true
  with camera
    \fade(0.5, {0, 0, 0, 1}, ->
      \setFollowLerp 1
      export colors = randomChoice colorSchemes
      sprites\refreshColors!
      dungeon\destruct!
      export dungeon = Dungeon #dungeon.rooms + random(2, 4)
      \fade(0.5, {0, 0, 0, 0}, ->
        \setFollowLerp 0.2
        player.disableMovement = false
      )
    )
  
  
  
