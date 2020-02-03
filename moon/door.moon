export class Door extends Entity
    new: (x, y, @orientation, @room) =>
        super x, y, sprites.door[@orientation]
        items, len = world\queryRect @pos.x, @pos.y, @dim.x, @dim.y
        for _, item in pairs items
            if item.__class == Wall then
                room.entities[item] = nil
                world\remove item