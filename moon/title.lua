local title = { }
local text
text = function(s, font, y)
  local x = gameWidth / 2 - font:getWidth(s) / 2
  love.graphics.setFont(font)
  return love.graphics.print(s, x, y)
end
local titleText = "Unknown\n      Depths"
title.enter = function(self, previous) end
title.draw = function(self)
  push:start()
  text(titleText, fontFantasy, 16)
  local y = 74
  text("PRESS ENTER TO START", fontRetro, screenHeight - y)
  text("PRESS ESC TO EXIT", fontRetro, screenHeight - y + 10)
  text("© 2020", fontRetro, screenHeight - 16)
  return push:finish()
end
return title
