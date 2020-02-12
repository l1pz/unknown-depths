import sin, floor from math

help = {}

help.y = 16
help.text = "Help"

color = {0,0,0,0}

move = ->
  flux.to(help, 0.48, {y: 32})\ease("cubicin")\oncomplete(->
    flux.to(help, 0.48, {y: 16})\ease("cubicout")\oncomplete(move)
  )

text = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

help.enter = (previous) =>
    color = {0,0,0,0}
    move!
  
help.update = (dt) =>
  flux.update dt

help.draw = () =>
  -- draw the level
  push\start!
  text @text, fontFantasy, floor(@y)
  y = 74
  text "WASD - MOVEMENT\nARROW KEYS - ATTACK\nYOUR GOAL IS TO FIND THE SECRETS OF THE UNKNOWN DEPTHS. THE DEEPER YOU THE MORE YOU WILL DISCOVER. WATCH OUT FOR THE DEADLY CREATURES OF THE DEPTHS, THEY WILL TRY TO STOP YOU.", fontRetro, 0
  love.graphics.setColor color
  love.graphics.rectangle "fill", 0, 0, gameWidth, screenHeight
  push\finish!

help.keypressed = (key) =>
  switch key
    when "return" or "escape"
      flux.to(color, 0.5, {0,0,0,1})\oncomplete(->
        manager\pop!
      )

return help