local title = { }
title.draw = function(self)
  push:start()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", 10, 10, 10)
  return push:finish()
end
return title
