local insert
insert = table.insert
inspect = require("libs/inspect")
Vector = require("libs/vector")
local bump = require("libs/bump")
local Camera = require("libs/camera")
local push = require("libs/push")
require("moon/helpers")
require("moon/input")
require("moon/sprites")
require("moon/entity")
require("moon/dungeon")
require("moon/player")
require("moon/wall")
require("moon/room")
require("moon/door")
gameWidth = 256
gameHeight = 224
tileSize = 16
world = bump.newWorld()
local windowScale = 4
local windowWidth = gameWidth * windowScale
local windowHeight = gameHeight * windowScale
local roomsCount = 3
local colorSchemes = { }
local colorScheme = 1
local dungeon
local camera
debugDrawSprites = true
debugDrawCollisionBoxes = false
love.load = function()
  love.joystick.loadGamepadMappings("assets/misc/gamecontrollerdb.txt")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setLineStyle("rough")
  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
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
  sprites:load()
  dungeon = Dungeon(roomsCount)
  center = dungeon.currentRoom.center
  camera = Camera(center.x, center.y, gameWidth, gameHeight)
  do
    camera:setFollowStyle("SCREEN_BY_SCREEN")
    camera:setFollowLerp(0.2)
    camera.scale = 1
  end
  player = Player(center.x, center.y)
end
love.update = function(dt)
  do
    camera:update(dt)
    camera:follow(player.pos.x, player.pos.y)
  end
  input:update()
  dungeon:update(dt)
  return player:update(dt)
end
love.draw = function()
  push:start()
  camera:attach()
  dungeon:draw()
  player:draw()
  camera:detach()
  camera:draw()
  return push:finish()
end
