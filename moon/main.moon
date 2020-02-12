import insert from table
export inspect = require "libs/inspect"
export Vector = require "libs/vector"
export bump = require "libs/bump"
export Camera = require "libs/camera"
export push = require "libs/push"
roomy = require "libs/roomy"
export ripple = require "libs/ripple"
export flux = require "libs/flux"

export manager = roomy.new!

require "moon/helpers"
require "moon/input"
require "moon/ui"
require "moon/sprites"
require "moon/sounds"
require "moon/item"
require "moon/entity"

-- Weapons
require "moon/weapon"
require "moon/arrow"
require "moon/bow"

-- Spells
require "moon/ignite"

require "moon/dungeon"
require "moon/player"
require "moon/wall"
require "moon/room"
require "moon/door"
require "moon/chest"
require "moon/stairs"

export gameWidth = 256
export gameHeight = 224
export uiWidth = gameWidth
export uiHeight = 40
export tileSize = 16
export screenHeight = gameHeight + uiHeight

export font

fullScreen = true
local windowWidth, windowHeight
windowScale = 3

windowWidth, windowHeight = if fullScreen
  love.window.getDesktopDimensions()
else
  gameWidth * windowScale, screenHeight * windowScale

export colors
export colorSchemes = {}
export colorScheme = 6

export states = {
  gameplay: require "moon/gameplay"
  title: require "moon/title"
  help: require "moon/help"
}

love.load = ->
  love.joystick.loadGamepadMappings "assets/misc/gamecontrollerdb.txt"
  love.graphics.setDefaultFilter "nearest", "nearest"
  love.graphics.setLineStyle "rough"
  
  push\setupScreen gameWidth, gameHeight + uiHeight, windowWidth, windowHeight, {
    fullscreen: fullScreen
    resizeable: false
    pixelperfect: true
  }

  dir = "assets/colors/"
  files = love.filesystem.getDirectoryItems(dir)
  for file in *files do
    scheme = require dir .. file\sub(1, #file - 4)
    insert colorSchemes, scheme
  colors = colorSchemes[colorScheme]

  export fontGameplay = love.graphics.newImageFont 'assets/sprites/font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', -1
  export fontRetro = love.graphics.newFont("assets/misc/retro.ttf", 8, "mono")
  export fontFantasy = love.graphics.newFont("assets/misc/fantasy.ttf", 66, "mono")

  sprites\load!
  sounds\load!

  manager\hook!
  manager\enter states.title

  
