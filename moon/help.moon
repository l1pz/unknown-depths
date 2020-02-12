import sin, floor from math

help = {}
help.text = "Help"
help.height = 16
help.y = help.height

move = ->
  flux.to(help, 0.48, {y: help.height + 16 })\ease("cubicin")\oncomplete(->
    flux.to(help, 0.48, {y: help.height})\ease("cubicout")\oncomplete(move)
  )

move!

textCentered = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

text = (s, font, y) ->
  love.graphics.setFont font
  love.graphics.print(s, 0, y)
  
help.update = (dt) =>
  flux.update dt

help.draw = () =>
  -- draw the level
  push\start!
  textCentered @text, fontFantasy, floor(@y)
  text "WASD - MOVEMENT\n\nARROW KEYS - ATTACK\n\n
YOUR GOAL IS TO FIND THE SECRETS\n
OF THE UNKNOWN DEPTHS. THE\n
DEEPER YOU GO THE MORE YOU WILL\n
DISCOVER. WATCH OUT FOR THE\n
DEADLY CREATURES OF THE DEPTHS,\n
THEY WILL TRY TO STOP YOU.", fontRetro, 96
  push\finish!

help.keypressed = (key) =>
  if key == "return" or key == "escape" or key == "h"
    manager\pop!

return help