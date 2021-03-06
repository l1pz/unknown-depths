local insert
insert = table.insert
inspect = require("libs/inspect")
Vector = require("libs/vector")
local bump = require("libs/bump")
local Camera = require("libs/camera")
local push = require("libs/push")
require("moon/helpers")
require("moon/input")
require("moon/ui")
require("moon/sprites")
require("moon/item")
require("moon/entity")
require("moon/weapon")
require("moon/bow")
require("moon/ignite")
require("moon/dungeon")
require("moon/player")
require("moon/wall")
require("moon/room")
require("moon/door")
require("moon/chest")
require("moon/stairs")
gameWidth = 256
gameHeight = 224
uiWidth = gameWidth
uiHeight = 40
tileSize = 16
world = bump.newWorld()
local fullScreen = true
local windowWidth, windowHeight
local windowScale = 3
if fullScreen then
  windowWidth, windowHeight = love.window.getDesktopDimensions()
else
  windowWidth = gameWidth * windowScale
  windowHeight = (gameHeight + uiHeight) * windowScale
end
local roomsCount = 5
colorSchemes = { }
local colorScheme = 6
local ui
debugDrawSprites = true
debugDrawCollisionBoxes = false
love.load = function()
  love.joystick.loadGamepadMappings("assets/misc/gamecontrollerdb.txt")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setLineStyle("rough")
  push:setupScreen(gameWidth, gameHeight + uiHeight, windowWidth, windowHeight, {
    fullscreen = fullScreen,
    resizeable = false,
    pixelperfect = true
  })
  local handle
  local _exp_0 = love.system.getOS()
  if "Windows" == _exp_0 then
    handle = io.popen("dir assets/colors /b /a-d")
  elseif "Linux" == _exp_0 then
    handle = io.popen("ls -A1 assets/colors/")
  end
  local fileNames = handle:read("*a")
  handle:close()
  for fileName in fileNames:gmatch("[^\r\n]+") do
    local scheme = require("assets/colors/" .. fileName:sub(1, #fileName - 4))
    insert(colorSchemes, scheme)
  end
  colors = colorSchemes[colorScheme]
  font = love.graphics.newImageFont('assets/sprites/font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', -1)
  love.graphics.setFont(font)
  ui = UI(uiWidth, uiHeight)
  sprites:load()
  player = Player(0, 0)
  dungeon = Dungeon(roomsCount)
  center = dungeon.currentRoom.center
  camera = Camera(center.x, center.y, gameWidth, gameHeight)
  do
    camera:setFollowStyle("SCREEN_BY_SCREEN")
    camera:setFollowLerp(0.2)
    camera.scale = 1
    return camera
  end
end
love.update = function(dt)
  do
    camera:update(dt)
    camera:follow(player.pos.x + player.offset.x, player.pos.y + player.offset.y)
  end
  input:update()
  dungeon:update(dt)
  return player:update(dt)
end
love.draw = function()
  push:start()
  love.graphics.translate(0, uiHeight)
  camera:attach()
  dungeon:draw()
  player:draw()
  camera:detach()
  camera:draw()
  love.graphics.translate(0, -uiHeight)
  ui:draw()
  return push:finish()
end
love.keypressed = function(key)
  local _exp_0 = key
  if "f1" == _exp_0 then
    debugDrawSprites = not debugDrawSprites
  elseif "f2" == _exp_0 then
    debugDrawCollisionBoxes = not debugDrawCollisionBoxes
  elseif "right" == _exp_0 then
    colorScheme = colorScheme + 1
    if colorScheme > #colorSchemes then
      colorScheme = 1
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "left" == _exp_0 then
    colorScheme = colorScheme - 1
    if colorScheme < 1 then
      colorScheme = #colorSchemes
    end
    colors = colorSchemes[colorScheme]
    return sprites:refreshColors()
  elseif "f3" == _exp_0 then
    return nextDungeon()
  elseif "escape" == _exp_0 then
    return love.event.quit()
  end
end
