export class Arrow extends Entity
  onCollision = (cols) ->
  for col in *cols
    other = col.other
    if other.__class == Wall 
      @stuck = true
  new: (@dir) =>
    @stuck = false
    @filter = (item, other) ->
      switch other.__class
        when Player
          return "cross"
      return "touch"
  update: (dt) =>
    unless stuck
      @move dir * 10 * dt, onCollision
    if input:pressed 'action' then
      playerShip:shoot()
    
  
  
  
    