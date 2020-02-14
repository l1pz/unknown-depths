local sin, floor
do
  local _obj_0 = math
  sin, floor = _obj_0.sin, _obj_0.floor
end
local death = { }
death.textTop = "YOU"
death.textBottom = "\nDIED"
death.height = 32
death.y = death.height
local move
move = function()
  return flux.to(death, 0.48, {
    y = death.height + 16
  }):ease("cubicin"):oncomplete(function()
    return flux.to(death, 0.48, {
      y = death.height
    }):ease("cubicout"):oncomplete(move)
  end)
end
move()
local textCentered
textCentered = function(s, font, y)
  local x = gameWidth / 2 - font:getWidth(s) / 2
  love.graphics.setFont(font)
  return love.graphics.print(s, x, y)
end
local text
text = function(s, font, y)
  love.graphics.setFont(font)
  return love.graphics.print(s, 0, y)
end
death.update = function(self, dt)
  return flux.update(dt)
end
death.draw = function(self)
  push:start()
  textCentered(self.textTop, fontFantasy, floor(self.y))
  textCentered(self.textBottom, fontFantasy, floor(self.y))
  textCentered("PRESS ANY KEY TO CONTINUE", fontRetro, screenHeight - 64)
  return push:finish()
end
death.keypressed = function(self, key)
  if key == "f" then
    return push:switchFullscreen(windowedWidth, windowedHeight)
  else
    return manager:enter(states.title, false)
  end
end
return death
