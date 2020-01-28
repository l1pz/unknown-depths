sprites = { }
local newSprite
newSprite = function(name)
  return love.graphics.newImage("assets/sprites/" .. tostring(name) .. ".png")
end
sprites.load = function(self)
  self.player = newSprite("player")
  self.wall = newSprite("wall")
  self.door = { }
  self.door.top = newSprite("doorTop")
  self.door.bottom = newSprite("doorBottom")
  self.door.right = newSprite("doorRight")
  self.door.left = newSprite("doorLeft")
  self.bow = newSprite("bow")
  self.weaponFrame = newSprite("weaponFrame")
  self.spellFrame = newSprite("spellFrame")
end
