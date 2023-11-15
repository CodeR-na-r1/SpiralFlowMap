require("vector")
require("vehicle")
require("flow")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    vehicle = Vehicle:create(width / 2, height / 2)
    map = FlowMap:create(11)
    -- map:init()
    map:initSpiral()
end

function love.update(dt)
    local x, y = love.mouse.getPosition()

    -- vehicle:follow(map)
    -- vehicle:borders()
    -- vehicle:update()
end

function love.draw()
    map:draw()
    vehicle:draw()
    
end

function love.mousepressed(x, y, button, istouch, presses)

end

function love.mousereleased(x, y, button, istouch, presses)

end
