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
  @weaponFrame = newSprite "weaponFrame"
  @spellFrame = newSprite "spellFrame"
  @heart = newSprite "heart"
  @healthText = newSprite "healthText"