import insert from table
export inspect = require "libs/inspect"
export Vector = require "libs/vector"
bump = require "libs/bump"
Camera = require "libs/camera"
push = require "libs/push"

require "moon/input"
require "moon/sprites"
require "moon/entity"
require "moon/dungeon"
require "moon/player"
require "moon/wall"
require "moon/room"
require "moon/door"

export gameWidth = 256
export gameHeight = 224
export tileSize = 16

export world = bump\newWorld!
export player

windowScale = 4
windowWidth = gameWidth * windowScale
windowHeight = gameHeight * windowScale

roomsCount = 3

export colors
colorSchemes = {}
colorScheme = 1

local dungeon
local camera

love.load = ->
  love.joystick.loadGamepadMappings "assets/misc/gamecontrollerdb.txt"
  love.graphics.setDefaultFilter "nearest", "nearest"
  love.graphics.setLineStyle "rough"
  
  push\setupScreen gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen: false
    resizeable: false
    pixelperfect: true
  }

  handle = switch love.system.getOS!
    when "Windows" io.popen "dir assets/colors /b /a-d"
    when "Linux" io.popen "ls -A1 assets/colors/"
  fileNames = handle\read "*a"
  handle\close!
  for fileName in fileNames\gmatch "[^\r\n]+"
    scheme = require "assets/colors/" .. fileName\sub(1, #fileName - 4)
    insert(colorSchemes, scheme)
  colors = colorSchemes[colorScheme]

  sprites\load!

  dungeon = Dungeon roomsCount
  
  center = dungeon.currentRoom.center
  camera = Camera center.x, center.y, gameWidth, gameHeight
  with camera
    \setFollowStyle "SCREEN_BY_SCREEN"
    \setFollowLerp 0.2
    .scale = 1
  
  player = Player center.x, center.y

love.update = (dt) ->
  with camera
    \update dt
    \follow player.pos.x, player.pos.y
  input\update!
  dungeon\update dt
  player\update dt
love.draw = ->
  push\start!
  camera\attach!
  dungeon\draw!
  player\draw!
  camera\detach!
  camera\draw!
  push\finish!


