import sin, floor from math

title = {}

title.y = 16
title.text = "Unknown\n      Depths"

local color

move = ->
  flux.to(title, 0.48, {y: 32})\ease("cubicin")\oncomplete(->
    flux.to(title, 0.48, {y: 16})\ease("cubicout")\oncomplete(move)
  )

move!

text = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

title.enter = (previous) =>
  sounds.titleMusic\play!
  color = {0,0,0,0}
  
title.update = (dt) =>
  flux.update dt


title.draw = () =>
  -- draw the level
  push\start!
  text @text, fontFantasy, floor(@y)
  y = 74
  text "ENTER TO START", fontRetro, screenHeight - y
  text "H FOR HELP", fontRetro, screenHeight - y + 12
  text "F FOR FULLSCREEN", fontRetro, screenHeight - y + 24
  text "ESC TO EXIT", fontRetro, screenHeight - y + 36
  text "© 2020", fontRetro, screenHeight - 16
  love.graphics.setColor color
  love.graphics.rectangle "fill", 0, 0, gameWidth, screenHeight
  push\finish!

title.keypressed = (key) =>
  switch key
    when "return"
      flux.to(color, 0.5, {0,0,0,1})\oncomplete(->
        color = {0,0,0,0}
        manager\push states.gameplay  
      )
    when "h"
      manager\push states.help
    when "f"
      push\switchFullscreen(windowedWidth, windowedHeight)
    when "escape" love.event.quit!

return title