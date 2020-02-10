title = {}

title.draw = () =>
  -- draw the level
  push\start!
  love.graphics.setColor(1,1,1)
  love.graphics.circle("fill", 10, 10, 10)
  push\finish!

return title