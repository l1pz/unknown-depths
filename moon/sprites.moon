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
  @door.topOpen = newSprite "doorTopOpen", "normal", "red"
  @door.bottomOpen = newSprite "doorBottomOpen", "normal", "red"
  @door.rightOpen = newSprite "doorRightOpen", "normal", "red"
  @door.leftOpen = newSprite "doorLeftOpen", "normal", "red"
  @bow = newSprite "bow", "normal", "green"
  @frame = newSprite "frame", "normal", "white"
  @heart = newSprite "heart", "normal", "red"
  @key = newSprite "key", "normal", "magenta"
  @bomb = newSprite "bomb", "normal", "cyan"
  @gold = newSprite "gold", "normal", "yellow"
  @ignite = newSprite "ignite", "normal", "red"
  @arrow = newSprite "arrowSmall", "normal", "cyan"
  @chestClosed = newSprite "chestClosed", "normal", "magenta"
  @chestOpen = newSprite "chestOpen", "normal", "magenta"
  @stairs = newSprite "stairs", "normal", "yellow"
  @undead = newSprite "undead", "normal", "green"
  @pixel = newSprite "pixel", "normal", "white"

sprites.refreshColors = =>
  for _, sprite in pairs spritesAll
      with sprite
        .color = colors[.colorType][.colorName]
