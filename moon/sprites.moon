import insert from table

export sprites = {}

spritesAll = {}

newSprite = (name, colorType, colorName) ->
  img = love.graphics.newImage "assets/sprites/#{name}.png"
  sprite =  {
    img: img
    width: img\getWidth!
    height: img\getHeight!
    color: colors[colorType][colorName]
    colorType: colorType
    colorName:colorName
  }
  insert spritesAll, sprite
  return sprite

sprites.load = =>
  @player = newSprite "player", "normal", "blue"
  @wall = newSprite "wall", "normal", "white"
  @door = {}
  @door.top = newSprite "doorTop", "normal", "red"
  @door.bottom = newSprite "doorBottom", "normal", "red"
  @door.right = newSprite "doorRight", "normal", "red"
  @door.left = newSprite "doorLeft", "normal", "red"
  @bow = newSprite "bow", "normal", "green"
  @frame = newSprite "frame", "normal", "white"
  @heart = newSprite "heart", "normal", "red"

sprites.refreshColors = =>
  for _, sprite in pairs spritesAll
      with sprite
        .color = colors[.colorType][.colorName]
