Tiles = {}

local function newStack()
    local stack = {}
    function stack:remove(id)
        for i, obj in ipairs(stack) do
            if obj.id and obj.id == id then
                table.remove(stack, i)
            end
        end
    end

    function stack:has(id)
        local res = false
        for i, obj in ipairs(stack) do
            if obj.id and obj.id == id then
                res = true
                break
            end
        end
        return res
    end

    function stack:add(obj)
        table.insert(stack, obj)
    end

    function stack:replace(tile)
        stack = tile
    end

    return stack
end

Tiles.empty = function()
    return newStack()
end

Tiles.wall = function()
    local stack = newStack()
    stack:add({id = "wall"})
    return stack
end

Tiles.stairs = function()
    local stack = newStack()
    stack:add({id = "stairs"})
    return stack
end

Tiles.hole = function()
    local stack = newStack()
    stack:add({id = "hole"})
    return stack
end

