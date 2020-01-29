export sprites = {}

newSprite = (name) ->
  return love.graphics.newImage "assets/sprites/#{name}.png"

sprites.load = =>
  @player = newSprite "player"
  @wall = newSprite "wall"
  @door = {}
  @door.top = newSprite "doorTop"
  @door.bottom = newSprite "doorBottom"
  @door.right = newSprite "doorRight"
  @door.left = newSprite "doorLeft"
  @bow = newSprite "bow"
  @frame = newSprite "frame"
  @heart = newSprite "heart"
