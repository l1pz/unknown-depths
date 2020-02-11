export class Door extends Entity
    new: (x, y, @orientation, @room) =>
        super x, y, sprites.door[@orientation .. "Open"]
        @closed = false
        items, len = world\queryRect @pos.x, @pos.y, @dim.x, @dim.y
        for _, item in pairs items
            if item.__class == Wall then
                @room\removeEntity item

    checkCurrentRoom: () =>
        if @room != dungeon.currentRoom and @room\isInside player.pos + player.offset
            dungeon.prevRoom = dungeon.currentRoom
            dungeon.currentRoom = @room
            print dungeon.currentRoom, dungeon.prevRoom

    open: =>
        @closed = false
        @changeSprite sprites.door[@orientation .. "Open"]

    close: =>
        items, len = world\queryRect @pos.x, @pos.y, @dim.x, @dim.y
        for _, item in pairs items
            if item.__class == Player then return
        @closed = true
        @changeSprite sprites.door[@orientation]