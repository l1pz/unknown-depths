do
  local _class_0
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(0, 0, 0)
      return love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, width, height, fgColor)
      self.width, self.height, self.fgColor = width, height, fgColor
    end,
    __base = _base_0,
    __name = "UI"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  UI = _class_0
end
