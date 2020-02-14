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

fadeIn = (fn = ->) ->
  print "fadeIn"
  export fadeColor = {0,0,0,1}
  flux.to(fadeColor, 0.5, {[4]: 0})\oncomplete(fn)

fadeOut = (fn = ->) ->
  export fadeColor = {0,0,0,0}
  flux.to(fadeColor, 0.5, {[4]: 1})\oncomplete(fn)
  
nextDungeon = -> 
  player.disableMovement = true
  camera\setFollowLerp 1
  fadeOut(->
    export colors = randomChoice colorSchemes
    sprites\refreshColors!
    dungeon\destruct!
    export dungeon = Dungeon #dungeon.rooms + random(2, 4)  
    fadeIn(->
      camera\setFollowLerp 0.2
      player.disableMovement = false
    )
  )
  
  
  
