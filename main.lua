g = love.graphics
require "settings"
require "stage"
require "tiles"
require "misc"

love.window.setTitle(Settings.title);
-- Settings.window_dimensions[1], Settings.window_dimensions[2] = love.window.getDesktopDimensions()
love.window.setMode(Settings.window_dimensions[1], Settings.window_dimensions[2])
love.window.setFullscreen(Settings.fullscreen)

-- Scenes = {
--     main_menu = MainMenu(),
-- }
-- -- adds scenes from /scenes
-- current_scene = Scenes.main_menu

local stage = Stage:init()

function love.load()
    if not stage then error "stage is nil" end
    -- checks whether .funcion is not nil before calling
    -- if not current_scene.loaded and current_scene.load then current_scene.load() end
    g.setBackgroundColor(0.6, 0.6, 0.8, 1.0)
    for i = 1, 5 do
        for j = 1, 5 do
            stage:add(i - 1, j - 1, 1, Tiles.empty())
        end
    end
    stage:add(5, 4, 1, Tiles.empty())
    stage:add(6, 4, 1, Tiles.empty())
    stage:add(6, 3, 1, Tiles.empty())
    stage:add(7, 3, 1, Tiles.empty())
    stage:add(8, 3, 1, Tiles.empty())
    stage:add(9, 3, 1, Tiles.empty())
    stage:add(10, 3, 1, Tiles.empty())
    stage:add(11, 3, 1, Tiles.empty())
    stage:get(1, 2, 1):replace(Tiles.stairs())
    for i = 1, 5 do
        for j = 1, 5 do
            stage:add(i - 1, j - 1, 2, Tiles.empty())
        end
    end
    stage:get(1, 3, 2):replace(Tiles.hole())
    stage:add(5, 4, 2, Tiles.empty())
    stage:add(6, 4, 2, Tiles.empty())
    stage:add(6, 3, 2, Tiles.empty())
    stage:add(7, 3, 2, Tiles.empty())
    stage:add(8, 3, 2, Tiles.empty())
    stage:add(9, 3, 2, Tiles.empty())
    stage:add(10, 3, 2, Tiles.empty())
    stage:add(11, 3, 2, Tiles.empty())
    stage:add(12, 3, 2, Tiles.empty())
    stage:addChar(3, 3, 1)
    stage:addChar(3, 3, 2)
end

function love.update(dt)
    -- relaunches the game when r is pressed
    if love.keyboard.isDown("lctrl") and love.keyboard.isDown("r") then love.event.quit "restart" end
    -- if current_scene.update then current_scene.update(dt) end
end

function love.draw()
    if not stage then error "stage is nil" end
    stage:draw()
    -- if current_scene.draw then current_scene.draw() end
end

function love.keypressed(k)
    if not stage then error "stage is nil" end
    if k == "w" then stage:move12() end
    if k == "d" then stage:move3() end
    if k == "s" then stage:move6() end
    if k == "a" then stage:move9() end
    if k == "z" then stage.level = 1 end
    if k == "x" then stage.level = 2 end
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
