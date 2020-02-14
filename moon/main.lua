local insert
insert = table.insert
local floor, min
do
  local _obj_0 = math
  floor, min = _obj_0.floor, _obj_0.min
end
inspect = require("libs/inspect")
Vector = require("libs/vector")
bump = require("libs/bump")
Camera = require("libs/camera")
push = require("libs/push")
local roomy = require("libs/roomy")
ripple = require("libs/ripple")
flux = require("libs/flux")
tick = require("libs/tick")
manager = roomy.new()
require("moon/shaders")
require("moon/helpers")
require("moon/input")
require("moon/ui")
require("moon/sprites")
require("moon/sounds")
require("moon/item")
require("moon/entity")
require("moon/weapon")
require("moon/arrow")
require("moon/bow")
require("moon/ignite")
require("moon/undead")
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
screenHeight = gameHeight + uiHeight
local windowScale = 3
windowedWidth, windowedHeight = love.window.getDesktopDimensions()
local windowedScale = min(floor(windowedWidth / gameWidth), floor(windowedHeight / screenHeight) - 1)
windowedWidth = gameWidth * windowedScale
windowedHeight = screenHeight * windowedScale
colorSchemes = { }
colorScheme = 6
states = {
  gameplay = require("moon/gameplay"),
  title = require("moon/title"),
  help = require("moon/help")
}
love.load = function()
  love.joystick.loadGamepadMappings("assets/misc/gamecontrollerdb.txt")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setLineStyle("rough")
  push:setupScreen(gameWidth, gameHeight + uiHeight, windowedWidth, windowedHeight, {
    resizeable = false,
    pixelperfect = true
  })
  shaders:load()
  local dir = "assets/colors/"
  local files = love.filesystem.getDirectoryItems(dir)
  for _index_0 = 1, #files do
    local file = files[_index_0]
    local scheme = require(dir .. file:sub(1, #file - 4))
    insert(colorSchemes, scheme)
  end
  colors = colorSchemes[colorScheme]
  fontGameplay = love.graphics.newImageFont('assets/sprites/font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', -1)
  fontRetro = love.graphics.newFont("assets/misc/retro.ttf", 8, "mono")
  fontFantasy = love.graphics.newFont("assets/misc/fantasy.ttf", 66, "mono")
  sprites:load()
  sounds:load()
  manager:hook()
  return manager:enter(states.title)
end
