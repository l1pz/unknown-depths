local sin, floor
do
  local _obj_0 = math
  sin, floor = _obj_0.sin, _obj_0.floor
end
local help = { }
help.startY = 0
help.y = help.startY
help.text = "Help"
local color = {
  0,
  0,
  0,
  0
}
local move
move = function()
  return flux.to(help, 0.48, {
    y = help.startY + 16
  }):ease("cubicin"):oncomplete(function()
    return flux.to(help, 0.48, {
      y = help.startY
    }):ease("cubicout"):oncomplete(move)
  end)
end
local text
text = function(s, font, y)
  love.graphics.setFont(font)
  return love.graphics.print(s, 0, y)
end
textCenter = function(s, font, y)
    local x = gameWidth / 2 - font:getWidth(s) / 2
    love.graphics.setFont(font)
    return love.graphics.print(s, x, y)
  end
help.enter = function(self, previous)
    color = {
        0,
        0,
        0,
        0
      }
  return move()
end
help.update = function(self, dt)
  return flux.update(dt)
end
help.draw = function(self)
  push:start()
  textCenter(self.text, fontFantasy, floor(self.y))
  local y = 96
  text("WASD - MOVEMENT\nARROW KEYS - ATTACK\n\nYOUR GOAL IS TO FIND THE SECRETS\nOF THE UNKNOWN DEPTHS. THE\nDEEPER YOU THE MORE YOU WILL\nDISCOVER. WATCH OUT FOR THE\nDEADLY CREATURES OF THE DEPTHS,\nTHEY WILL TRY TO STOP YOU.", fontRetro, y)
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", 0, 0, gameWidth, screenHeight)
  return push:finish()
end
help.keypressed = function(self, key)
  local _exp_0 = key
  if ("return" or "escape") == _exp_0 then
    return flux.to(color, 0.5, {
      0,
      0,
      0,
      1
    }):oncomplete(function()
      return manager:pop()
    end)
  end
end
return help