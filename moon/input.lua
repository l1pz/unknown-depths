local baton = require("libs/baton")
input = baton.new({
  controls = {
    moveLeft = {
      "key:a",
      "axis:leftx-",
      "button:dpleft"
    },
    moveRight = {
      "key:d",
      "axis:leftx+",
      "button:dpright"
    },
    moveUp = {
      "key:w",
      "axis:lefty-",
      "button:dpup"
    },
    moveDown = {
      "key:s",
      "axis:lefty+",
      "button:dpdown"
    },
    attackLeft = {
      "key:left"
    },
    attackRight = {
      "key:right"
    },
    attackUp = {
      "key:up"
    },
    attackDown = {
      "key:down"
    },
    action = {
      "key:x",
      "button:a"
    }
  },
  pairs = {
    move = {
      "moveLeft",
      "moveRight",
      "moveUp",
      "moveDown"
    },
    attack = {
      "attackLeft",
      "attackRight",
      "attackUp",
      "attackDown"
    }
  },
  joystick = love.joystick.getJoysticks()[1]
})
