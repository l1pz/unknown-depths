export class Door extends Entity
    new: (x, y, @orientation, @room) =>
        super x, y, sprites.door[@orientation], "normal", "red"
        items, len = world\quearyRect @pos.x, @pos.y, @dim.x, @dim.y
        for _, item in pairs items
            if item.__class == Wall then
                room.walls[item] = nil
                world\remove item