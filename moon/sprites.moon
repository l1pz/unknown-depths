export sprites = {}
sprites.load = =>
  @player      = love.graphics.newImage "assets/sprites/player.png"
  @wall        = love.graphics.newImage "assets/sprites/wall.png"
  @door        = {}
  @door.top    = love.graphics.newImage "assets/sprites/doorTop.png"
  @door.bottom = love.graphics.newImage "assets/sprites/doorBottom.png"
  @door.right  = love.graphics.newImage "assets/sprites/doorRight.png"
  @door.left   = love.graphics.newImage "assets/sprites/doorLeft.png"