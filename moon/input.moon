baton = require "libs/baton"
export input = baton.new{
  controls: {
    left: {"key:a", "axis:leftx-", "button:dpleft"}
    right: {"key:d", "axis:leftx+", "button:dpright"}
    up: {"key:w", "axis:lefty-", "button:dpup"}
    down: {"key:s", "axis:lefty+", "button:dpdown"}
    action: {"key:x", "button:a"}
  }
  pairs: {
    move: {"left", "right", "up", "down"}
  }
  joystick: love.joystick.getJoysticks![1]
}