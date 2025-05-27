require "settings"
require "tiles"

g = love.graphics

love.window.setTitle(Settings.title);
-- Settings.window_dimensions[1], Settings.window_dimensions[2] = love.window.getDesktopDimensions()
love.window.setMode(Settings.window_dimensions[1], Settings.window_dimensions[2])
love.window.setFullscreen(Settings.fullscreen)

-- Scenes = {
--     main_menu = MainMenu(),
-- }
-- -- adds scenes from /scenes
-- current_scene = Scenes.main_menu

local grass_img = g.newImage("res/grass.png")
local player_img = g.newImage("res/Screenshot 2023-12-18 220345.png")
local level = {}

function level:get(x, y)
    if level[x + 1][y + 1] then return level[x + 1][y + 1]
    else return end
end

function level:move12()
    for i, coords in ipairs(level.chars) do
        if coords.y - 1 >= 0 then
            level:get(coords.x, coords.y).char = false
            level:get(coords.x, coords.y - 1).char = true
            coords.y = coords.y - 1
        end
    end
end

function level:move3()
    for i, coords in ipairs(level.chars) do
        if coords.x + 1 < level.width then
            level:get(coords.x, coords.y).char = false
            level:get(coords.x + 1, coords.y).char = true
            coords.x = coords.x + 1
        end
    end
end

function level:move6()
    for i, coords in ipairs(level.chars) do
        if coords.y + 1 < level.height then
            level:get(coords.x, coords.y).char = false
            level:get(coords.x, coords.y + 1).char = true
            coords.y = coords.y + 1
        end
    end
end


function level:move9()
    for i, coords in ipairs(level.chars) do
        if coords.x - 1 >= 0 then
            level:get(coords.x, coords.y).char = false
            level:get(coords.x - 1, coords.y).char = true
            coords.x = coords.x - 1
        end
    end
end

local screen_width, screen_height = Settings.window_dimensions[1], Settings.window_dimensions[2]

function love.load()
    -- checks whether .funcion is not nil before calling
    -- if not current_scene.loaded and current_scene.load then current_scene.load() end
    g.setBackgroundColor(0.6, 0.6, 0.8, 1.0)
    level.width = 5
    level.height = 5
    for i = 1, level.width do
        level[i] = Tiles.empty()
        for j = 1, level.height do
            level[i][j] = Tiles.empty()
        end
    end
    level:get(0, 3).char = true
    level.chars = {{x = 0, y = 3}}
end

function love.update(dt)
    -- relaunches the game when r is pressed
    -- if love.keyboard.isDown("lctrl") and love.keyboard.isDown("r") then love.event.quit "restart" end
    -- if current_scene.update then current_scene.update(dt) end
end

local tile_scale = 0.5
local tile_width, tile_height = grass_img:getWidth() * tile_scale, grass_img:getHeight() * tile_scale

function love.draw()
    g.push()
    g.setColor(1.0, 1.0, 1.0, 1.0)
    local total_width, total_height = tile_width * #level, tile_height * #level[1]
    local start_x, start_y = (screen_width - total_width) / 2, (screen_height - total_height) / 2
    for i = 0, #level - 1 do
        for j = 0, #level[1] - 1 do
            g.draw(grass_img, start_x + i * tile_width, start_y + j * tile_height, 0, tile_scale, tile_scale)
            if level:get(i, j).char then
                g.draw(player_img, start_x + i * tile_width, start_y + j * tile_height, 0, tile_scale * 2, tile_scale * 2)
            end
        end
    end
    g.pop()
    -- if current_scene.draw then current_scene.draw() end
end

function love.keypressed(k)
    if k == "w" then level:move12() end
    if k == "d" then level:move3() end
    if k == "s" then level:move6() end
    if k == "a" then level:move9() end
end

function love.keyreleased(k)
    -- if current_scene.keyboardreleased then current_scene.keyboardreleased(k) end
end

function love.mousepressed(x, y, button)
    -- if current_scene.mousepressed then current_scene.mousepressed(x, y, button) end
end

function love.mousereleased(x, y, button)
    -- if current_scene.mousereleased then current_scene.mousereleased(x, y, button) end
end

function ChangeScene(nextScene)
    current_scene = Scenes[nextScene]
    current_scene.load()
    
end

function ReloadScene()
    current_scene.load()
end
