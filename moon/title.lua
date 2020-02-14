local sin, floor
do
  local _obj_0 = math
  sin, floor = _obj_0.sin, _obj_0.floor
end
local title = { }
title.y = 16
title.text = "Unknown\n      Depths"
local color
local move
move = function()
  return flux.to(title, 0.48, {
    y = 32
  }):ease("cubicin"):oncomplete(function()
    return flux.to(title, 0.48, {
      y = 16
    }):ease("cubicout"):oncomplete(move)
  end)
end
move()
local text
text = function(s, font, y)
  local x = gameWidth / 2 - font:getWidth(s) / 2
  love.graphics.setFont(font)
  return love.graphics.print(s, x, y)
end
title.enter = function(self, previous)
  color = {
    0,
    0,
    0,
    0
  }
  return print("enter")
end
title.update = function(self, dt)
  return flux.update(dt)
end
title.draw = function(self)
  push:start()
  text(self.text, fontFantasy, floor(self.y))
  local y = 74
  text("PRESS ENTER TO START", fontRetro, screenHeight - y)
  text("PRESS ESC TO EXIT", fontRetro, screenHeight - y + 10)
  text("© 2020", fontRetro, screenHeight - 16)
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", 0, 0, gameWidth, screenHeight)
  return push:finish()
end
title.keypressed = function(self, key)
  local _exp_0 = key
  if "return" == _exp_0 then
    return flux.to(color, 0.5, {
      0,
      0,
      0,
      1
    }):oncomplete(function()
      color = {
        0,
        0,
        0,
        0
      }
      return manager:push(states.gameplay)
    end)
  elseif "escape" == _exp_0 then
    return love.event.quit()
  end
end
return title
