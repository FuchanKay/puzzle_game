require "tiles"
local screen_width, screen_height = Settings.window_dimensions[1], Settings.window_dimensions[2]
local grass_img = g.newImage("res/grass.png")
local gravel_img = g.newImage("res/gravel.png")
local player_img = g.newImage("res/skeleton_enemy_black.png")
local hole_img = g.newImage("res/hole.png")
local tile_scale = 0.5
local tile_width, tile_height = grass_img:getWidth() * tile_scale, grass_img:getHeight() * tile_scale
Stage = {}
function Stage:init()
    local stage = {
        width = 0, length = 0, height = 1,
        level = 1,
        chars = {}
    }
    function stage:get(x, y, z)
        if z == nil then return stage[processCoords(x, y, 1)] end
        return stage[processCoords(x, y, z)]
    end

    function stage:add(x, y, z, tile)
        stage[processCoords(x, y, z)] = tile
        if stage.width < x then stage.width = x end
        if stage.length < y then stage.length = y end
        if stage.height < z then stage.height = z end
    end

    function stage:addChar(x, y, z)
        local char = {x = x, y = y, z = z, id = "char"}
        table.insert(stage.chars, char)
        table.insert(stage:get(x, y, z), char)
    end

    function stage:move12()
        for i, char in ipairs(stage.chars) do
            if stage:get(char.x, char.y - 1, char.z) and char.z == stage.level then
                stage:get(char.x, char.y, char.z):remove("char")
                stage:get(char.x, char.y - 1, char.z):add(char)
                char.y = char.y - 1
                print(char.x, char.y, char.z)
            end
        end
    end

    function stage:move3()
        for i, char in ipairs(stage.chars) do
            if stage:get(char.x + 1, char.y, char.z) and char.z == stage.level then
                stage:get(char.x, char.y, char.z):remove("char")
                stage:get(char.x + 1, char.y, char.z):add(char)
                char.x = char.x + 1
                print(char.x, char.y, char.z)
            end
        end
    end

    function stage:move6()
        for i, char in ipairs(stage.chars) do
            if stage:get(char.x, char.y + 1, char.z) and char.z == stage.level then
                stage:get(char.x, char.y, char.z):remove("char")
                stage:get(char.x, char.y + 1, char.z):add(char)
                char.y = char.y + 1
                print(char.x, char.y, char.z)
            end
        end
    end

    function stage:move9()
        for i, char in ipairs(stage.chars) do
            if stage:get(char.x - 1, char.y, char.z) and char.z == stage.level then
                stage:get(char.x, char.y, char.z):remove("char")
                stage:get(char.x - 1, char.y, char.z):add(char)
                char.x = char.x - 1
                print(char.x, char.y, char.z)
            end
        end
    end

    function stage:update(dt)

    end

    function stage:draw()
        g.push()
        g.setColor(1.0, 1.0, 1.0, 1.0)
        local total_width, total_height = tile_width * stage.width, tile_height * stage.length
        local start_x, start_y = (screen_width - total_width) / 2, (screen_height - total_height) / 2
        for i = 0, stage.width do
            for j = 0, stage.length do
                local img = grass_img
                if stage.level == 1 then img = gravel_img end
                if stage:get(i, j, stage.level) then
                    g.draw(img, start_x + i * tile_width, start_y + j * tile_height, 0, tile_scale, tile_scale)
                    for k, obj in ipairs(stage:get(i, j, stage.level)) do
                        if obj.id == "char" then g.draw(player_img, start_x + i * tile_width, start_y + j * tile_height, 0, tile_scale * 0.1, tile_scale * 0.1) end
                        if obj.id == "hole" then g.draw(hole_img, start_x + i * tile_width, start_y + j * tile_height, 0, tile_scale , tile_scale) end
                    end
                end
            end
        end
        g.pop()
    end

    return stage
end
