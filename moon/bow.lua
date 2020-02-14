local pi
pi = math.pi
do
  local _class_0
  local _parent_0 = Item
  local _base_0 = {
    update = function(self, dt, playerDir)
      self.psystem:update(dt)
      if input:down("attack") and not player.disableAttacking then
        local pos = player.pos + player.offset
        local ax, ay = input:get("attack")
        local attackDir = Vector(ax, ay)
        if attackDir * playerDir == 0 then
          attackDir = attackDir + (playerDir * 0.4)
        end
        attackDir = attackDir.normalized
        local arrowPos = pos + attackDir * 10
        local arrow = Arrow(arrowPos, attackDir)
        dungeon.currentRoom.entities[arrow] = arrow
      end
    end,
    draw = function(self)
      love.graphics.setColor(1, 1, 1)
      return love.graphics.draw(self.psystem, 0, 0)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self, sprites.bow)
      self.psystem = love.graphics.newParticleSystem(sprites.pixel.img, 32)
      do
        local _with_0 = self.psystem
        _with_0:setParticleLifetime(0.1, 0.1)
        _with_0:setSpeed(100)
        _with_0:setSpread(pi * 0.5)
        _with_0:setColors(1, 1, 1, 1)
        return _with_0
      end
    end,
    __base = _base_0,
    __name = "Bow",
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
  Bow = _class_0
end
