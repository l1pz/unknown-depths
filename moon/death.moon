import sin, floor from math

death = {}
death.textTop = "YOU"
death.textBottom = "\nDIED"
death.height = 32
death.y = death.height

move = ->
  flux.to(death, 0.48, {y: death.height + 16 })\ease("cubicin")\oncomplete(->
    flux.to(death, 0.48, {y: death.height})\ease("cubicout")\oncomplete(move)
  )

move!

textCentered = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

text = (s, font, y) ->
  love.graphics.setFont font
  love.graphics.print(s, 0, y)
  
death.update = (dt) =>
  flux.update dt

death.draw = () =>
  -- draw the level
  push\start!
  textCentered @textTop, fontFantasy, floor(@y)
  textCentered @textBottom, fontFantasy, floor(@y)
  textCentered "YOUR DEPTH BEFORE DYING WAS #{depth}", fontRetro, screenHeight - 64
  textCentered "PRESS ANY KEY TO CONTINUE", fontRetro, screenHeight - 48
  push\finish!

death.keypressed = (key) =>
  if key == "f"
    push\switchFullscreen(windowedWidth, windowedHeight)
  else 
    manager\enter states.title, false

return death