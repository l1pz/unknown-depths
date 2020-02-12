local sin, floor
do
  local _obj_0 = math
  sin, floor = _obj_0.sin, _obj_0.floor
end
local help = { }
help.text = "Help"
help.height = 16
help.y = help.height
local move
move = function()
  return flux.to(help, 0.48, {
    y = help.height + 16
  }):ease("cubicin"):oncomplete(function()
    return flux.to(help, 0.48, {
      y = help.height
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
help.update = function(self, dt)
  return flux.update(dt)
end
help.draw = function(self)
  push:start()
  textCentered(self.text, fontFantasy, floor(self.y))
  text("WASD - MOVEMENT\n\nARROW KEYS - ATTACK\n\n\nYOUR GOAL IS TO FIND THE SECRETS\n\nOF THE UNKNOWN DEPTHS. THE\n\nDEEPER YOU GO THE MORE YOU WILL\n\nDISCOVER. WATCH OUT FOR THE\n\nDEADLY CREATURES OF THE DEPTHS,\n\nTHEY WILL TRY TO STOP YOU.", fontRetro, 96)
  return push:finish()
end
help.keypressed = function(self, key)
  if key == "return" or key == "escape" or key == "h" then
    return manager:pop()
  end
end
return help
