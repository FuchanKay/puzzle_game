Level = {}
require "tiles"

function Level:init(width, height)
    local level = {}
    level.width, level.height = width, height

    for i = 1, width do
        level[i] = Tiles.empty()
        for j = 1, height do
            level[i][j] = Tiles.empty()
        end
    end
end



