Tiles = {}

function Tiles:init()
end

Tiles.empty = function()
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
    return stack
end