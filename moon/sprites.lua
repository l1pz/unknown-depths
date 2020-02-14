local insert
insert = table.insert
sprites = { }
local spritesAll = { }
local newSprite
newSprite = function(name, colorType, colorName)
  local img = love.graphics.newImage("assets/sprites/" .. tostring(name) .. ".png")
  local sprite = {
    img = img,
    width = img:getWidth(),
    height = img:getHeight(),
    color = colors[colorType][colorName],
    colorType = colorType,
    colorName = colorName
  }
  insert(spritesAll, sprite)
  return sprite
end
sprites.load = function(self)
  self.player = newSprite("player", "normal", "blue")
  self.wall = newSprite("wall", "normal", "white")
  self.door = { }
  self.door.top = newSprite("doorTop", "normal", "red")
  self.door.bottom = newSprite("doorBottom", "normal", "red")
  self.door.right = newSprite("doorRight", "normal", "red")
  self.door.left = newSprite("doorLeft", "normal", "red")
  self.door.topOpen = newSprite("doorTopOpen", "normal", "red")
  self.door.bottomOpen = newSprite("doorBottomOpen", "normal", "red")
  self.door.rightOpen = newSprite("doorRightOpen", "normal", "red")
  self.door.leftOpen = newSprite("doorLeftOpen", "normal", "red")
  self.bow = newSprite("bow", "normal", "green")
  self.frame = newSprite("frame", "normal", "white")
  self.heart = newSprite("heart", "normal", "red")
  self.key = newSprite("key", "normal", "magenta")
  self.bomb = newSprite("bomb", "normal", "cyan")
  self.gold = newSprite("gold", "normal", "yellow")
  self.ignite = newSprite("ignite", "normal", "red")
  self.arrow = newSprite("arrowSmall", "normal", "cyan")
  self.chestClosed = newSprite("chestClosed", "normal", "magenta")
  self.chestOpen = newSprite("chestOpen", "normal", "magenta")
  self.stairs = newSprite("stairs", "normal", "yellow")
  self.undead = newSprite("undead", "normal", "green")
end
sprites.refreshColors = function(self)
  for _, sprite in pairs(spritesAll) do
    do
      sprite.color = colors[sprite.colorType][sprite.colorName]
    end
  end
end
