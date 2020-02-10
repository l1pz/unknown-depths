local insert
insert = table.insert
inspect = require("libs/inspect")
Vector = require("libs/vector")
bump = require("libs/bump")
Camera = require("libs/camera")
push = require("libs/push")
local roomy = require("libs/roomy")
manager = roomy.new()
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
screenHeight = gameHeight + uiHeight
local fullScreen = false
local windowWidth, windowHeight
local windowScale = 3
if fullScreen then
  windowWidth, windowHeight = love.window.getDesktopDimensions()
else
  windowWidth, windowHeight = gameWidth * windowScale, screenHeight * windowScale
end
colorSchemes = { }
local colorScheme = 6
local states = {
  gameplay = require("moon/gameplay"),
  title = require("moon/title")
}
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
  fontGameplay = love.graphics.newImageFont('assets/sprites/font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', -1)
  fontRetro = love.graphics.newFont("assets/misc/retro.ttf", 8, "mono")
  fontFantasy = love.graphics.newFont("assets/misc/fantasy.ttf", 66, "mono")
  sprites:load()
  manager:hook()
  return manager:enter(states.title)
end
