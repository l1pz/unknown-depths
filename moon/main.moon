import insert from table
export inspect = require "libs/inspect"
export Vector = require "libs/vector"
bump = require "libs/bump"
Camera = require "libs/camera"
push = require "libs/push"

require "moon/helpers"
require "moon/input"
require "moon/ui"
require "moon/sprites"
require "moon/item"
require "moon/entity"

-- Weapons
require "moon/weapon"
require "moon/bow"

-- Spells
require "moon/ignite"

require "moon/dungeon"
require "moon/player"
require "moon/wall"
require "moon/room"
require "moon/door"
require "moon/chest"

export gameWidth = 256
export gameHeight = 224
export uiWidth = gameWidth
export uiHeight = 40
export tileSize = 16

export font

export world = bump.newWorld!
export player

fullScreen = true
local windowWidth, windowHeight
windowScale = 3

if fullScreen
  windowWidth, windowHeight = love.window.getDesktopDimensions()
else
  windowWidth = gameWidth * windowScale
  windowHeight = (gameHeight + uiHeight) * windowScale
 
roomsCount = 16

export colors
colorSchemes = {}
colorScheme = 6

export dungeon
local camera

local ui

export debugDrawSprites = true
export debugDrawCollisionBoxes = false

love.load = ->
  love.joystick.loadGamepadMappings "assets/misc/gamecontrollerdb.txt"
  love.graphics.setDefaultFilter "nearest", "nearest"
  love.graphics.setLineStyle "rough"
  
  push\setupScreen gameWidth, gameHeight + uiHeight, windowWidth, windowHeight, {
    fullscreen: fullScreen
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

  font = love.graphics.newImageFont 'assets/sprites/font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', -1
  love.graphics.setFont font 
  ui = UI uiWidth, uiHeight

  sprites\load!

  dungeon = Dungeon roomsCount
  
  export center = dungeon.currentRoom.center
  camera = Camera center.x, center.y, gameWidth, gameHeight
  with camera
    \setFollowStyle "SCREEN_BY_SCREEN"
    \setFollowLerp 0.2
    .scale = 1
  
  player = Player center.x - 7, center.y - 8

love.update = (dt) ->
  with camera
    \update dt
    \follow player.pos.x + player.offset.x, player.pos.y + player.offset.y
  input\update!
  dungeon\update dt
  player\update dt
love.draw = ->
  push\start!
  love.graphics.translate 0, uiHeight
  camera\attach!
  dungeon\draw!
  player\draw!
  camera\detach!
  camera\draw!
  love.graphics.translate 0, -uiHeight
  ui\draw!
  push\finish!

love.keypressed = (key) ->
  switch key
    when "f1" then debugDrawSprites = not debugDrawSprites
    when "f2" then debugDrawCollisionBoxes = not debugDrawCollisionBoxes
    when "right"
      colorScheme+=1
      if colorScheme > #colorSchemes then colorScheme = 1
      colors = colorSchemes[colorScheme]
      sprites\refreshColors!
    when "left"
      colorScheme-=1
      if colorScheme < 1 then colorScheme = #colorSchemes
      colors = colorSchemes[colorScheme]
      sprites\refreshColors!
  
