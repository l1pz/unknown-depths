export class Door extends Entity
  new: (x, y, @orientation, @room) =>
      super x, y, sprites.door[@orientation]