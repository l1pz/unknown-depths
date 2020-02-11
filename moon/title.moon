import sin, floor from math

title = {}

title.y = 16
title.text = "Unknown\n      Depths"

color = {0,0,0,0}

move = ->
  flux.to(title, 0.48, {y: 32})\ease("cubicin")\oncomplete(->
    flux.to(title, 0.48, {y: 16})\ease("cubicout")\oncomplete(move)
  )

text = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

title.enter = (previous) =>
  sounds.titleMusic\play!
  move!
  
  
title.update = (dt) =>
  flux.update dt


title.draw = () =>
  -- draw the level
  push\start!
  text @text, fontFantasy, floor(@y)
  y = 74
  text "PRESS ENTER TO START", fontRetro, screenHeight - y
  text "PRESS ESC TO EXIT", fontRetro, screenHeight - y + 10
  text "© 2020", fontRetro, screenHeight - 16
  love.graphics.setColor color
  love.graphics.rectangle "fill", 0, 0, gameWidth, screenHeight
  push\finish!

title.keypressed = (key) =>
  switch key
    when "return"
      flux.to(color, 0.5, {0,0,0,1})\oncomplete(->
        manager\enter states.gameplay  
      )
    when "escape" love.event.quit!

return title