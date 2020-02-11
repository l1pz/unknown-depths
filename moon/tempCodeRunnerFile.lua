return {
  draw = function(self)
    super()
    local pos = player.pos + player.offset
    local ax, ay = input:get("attack")
    local attackDir = Vector(ax, ay) * 10
    local epos = pos + attackDir
    love.graphics.setColor(1, 0, 0)
    return love.graphics.line(pos.x, pos.y, epos.x, epos.y)
  end
}
