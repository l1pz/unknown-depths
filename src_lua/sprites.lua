sprites = { }
sprites.load = function(self)
  self.player = love.graphics.newImage("assets/sprites/player.png")
  self.wall = love.graphics.newImage("assets/sprites/wall.png")
  self.door = { }
  self.door.top = love.graphics.newImage("assets/sprites/doorTop.png")
  self.door.bottom = love.graphics.newImage("assets/sprites/doorBottom.png")
  self.door.right = love.graphics.newImage("assets/sprites/doorRight.png")
  self.door.left = love.graphics.newImage("assets/sprites/doorLeft.png")
end
