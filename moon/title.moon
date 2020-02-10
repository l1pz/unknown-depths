title = {}

text = (s, font, y) ->
  x = gameWidth / 2 - font\getWidth(s) / 2
  love.graphics.setFont font
  love.graphics.print(s, x, y)

titleText = "Unknown\n      Depths"

title.enter = (previous) =>

title.draw = () =>
  -- draw the level
  push\start!
  text titleText, fontFantasy, 16
  y = 74
  text "PRESS ENTER TO START", fontRetro, screenHeight - y
  text "PRESS ESC TO EXIT", fontRetro, screenHeight - y + 10
  text "© 2020", fontRetro, screenHeight - 16
  push\finish!

return title