export class UI
  new: (@width, @height, @fgColor) =>
  draw: =>
    love.graphics.setColor 0, 0, 0
    love.graphics.rectangle "fill", 0, 0, @width, @height
