local baton = require("../libraries/baton")
input = baton.new({
  controls = {
    left = {
      "key:a",
      "axis:leftx-",
      "button:dpleft"
    },
    right = {
      "key:d",
      "axis:leftx+",
      "button:dpright"
    },
    up = {
      "key:w",
      "axis:lefty-",
      "button:dpup"
    },
    down = {
      "key:s",
      "axis:lefty+",
      "button:dpdown"
    }
  },
  pairs = {
    move = {
      "left",
      "right",
      "up",
      "down"
    }
  },
  joystick = love.joystick.getJoysticks()[1]
})