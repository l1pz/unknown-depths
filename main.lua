local insert
insert = table.insert
inspect = require("libraries/inspect")
Vector = require("libraries/vector")
local bump = require("libraries/bump")
local Camera = require("libraries/camera")
local push = require("libraries/push")
require("src_lua/input")
require("src_lua/sprites")
require("src_lua/entity")
require("src_lua/dungeon")
require("src_lua/player")
require("src_lua/wall")
require("src_lua/room")
require("src_lua/door")
gameWidth = 256
gameHeight = 224
tileSize = 16
world = bump.newWorld()
local windowScale = 4
local windowWidth = gameWidth * windowScale
local windowHeight = gameHeight * windowScale
local roomsCount = 3
local colorSchemes = { }
local dungeon
local camera
love.load = function(self)
  love.joystick.loadGamepadMappings("assets/misc/gamecontrollerdb.txt")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setLineStyle("rough")
  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = false,
    pixelperfect = true
  })
  print(love.system.getOS())
  local handle
  local _exp_0 = love.system.getOS()
  if "Windows" == _exp_0 then
    handle = io.popen("dir colors /b /a-d")
  elseif "Linux" == _exp_0 then
    handle = io.popen("ls -A1 assets/colors/")
  end
  local colorFileNamesRaw = handle:read("*a")
  handle:close()
  for fileName in colorFileNamesRaw:gmatch("[^\r\n]+") do
    local scheme = require("assets/colors/" .. fileName:sub(1, #fileName - 4))
    insert(colorSchemes, scheme)
  end
  colorScheme = 1
  colors = colorSchemes[colorScheme]
  sprites:load()
  dungeon = Dungeon(roomsCount)
  local center = dungeon.currentRoom.center
  camera = Camera(center.x, center.y, gameWidth, gameHeight)
  camera:setFollowStyle("SCREEN_BY_SCREEN")
  camera:setFollowLerp(0.2)
  camera.scale = 1
  player = Player(center.x, center.y)
end
love.update = function(dt)
  camera:update(dt)
  camera:follow(player.x, player.y)
  input:update()
  dungeon:update(dt)
  return player:update(dt)
end
love.draw = function() end
