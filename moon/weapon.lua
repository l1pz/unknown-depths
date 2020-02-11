local floor
floor = math.floor
do
  local _class_0
  local _parent_0 = Item
  local _base_0 = {
    changeSprite = function(self, sprite)
      self.sprite = sprite
      self.dim = Vector(self.sprite.width, self.sprite.height)
      local halfDim = self.dim / 2
      self.offset = Vector(floor(halfDim.x), floor(halfDim.y))
    end,
    draw = function(self)
      self.color = self.sprite.color
      return love.graphics.draw(self.sprite.img, floor(self.pos.x), floor(self.pos.y))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, sprite, cooldown, knockback)
      if cooldown == nil then
        cooldown = 0.5
      end
      if knockback == nil then
        knockback = 1
      end
      self.cooldown, self.knockback = cooldown, knockback
      return self:changeSprite(sprite)
    end,
    __base = _base_0,
    __name = "Weapon",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Weapon = _class_0
end
