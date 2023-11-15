FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create(n)
    local flow = {}
    setmetatable(flow, FlowMap)
    flow.field = {}
    love.math.setRandomSeed(10000)
    flow.n = n
    flow.width = width / flow.n
    flow.height = height / flow.n
    return flow
end

function FlowMap:init()
    local xoff = math.random(1, 100) / 100
    local yoff = math.random(1, 100) / 100
    
    for y=1, self.n do
        self.field[y] = {}
        for x=1, self.n do
            local theta = math.map(love.math.noise(xoff, yoff), 
                                                    0, 1, 0, math.pi * 2)
            self.field[y][x] = Vector:create(math.cos(theta), math.sin(theta))
            yoff = yoff + 0.1
        end
        xoff = xoff + 0.1
    end
end

function FlowMap:initSpiral()
    -- local xoff = math.random(1, 100) / 100
    -- local yoff = math.random(1, 100) / 100
    
    for y=1, self.n do
        self.field[y] = {}
        for x=1, self.n do

            local dirX = 1
            if x-1 < self.n /2 then
                dirX = -1
            elseif x-1 == self.n /2 then
                dirX = 0
            end

            local dirY = -1
            if y-1 < self.n /2 then
                dirY = 1
            elseif y-1 == self.n /2 then
                dirY = 0
            end
            
            -- dirY = y - 1 - self.n /2
            local xC = math.map(x, 1, self.n, 0, math.pi)
            local yC = math.map(y, 1, self.n, 0, math.pi)
            -- local theta = math.map(love.math.noise(xoff, yoff), 
            --                                         0, 1,
            --                                         0, math.pi * 2)
            self.field[y][x] = Vector:create(math.cos(xC) * dirX, math.sin(yC) * dirY)
            -- self.field[y][x] = Vector:create(xC, yC)
            -- yoff = yoff + 0.1
        end
        -- xoff = xoff + 0.1
    end
end

function FlowMap:draw()
    
    for y=1, self.n do
        for x=1, self.n do
            love.graphics.push()
            local xc = self.width * (x-1) + self.width / 2
            local yc = self.height * (y-1) + self.height / 2
            love.graphics.translate(xc, yc)
            local v = self.field[y][x]
            love.graphics.rotate(v:heading())
            local len = v:mag() * 20
            love.graphics.line(0, 0, len, 0)
            love.graphics.circle("fill", 0, 0, 5)
            love.graphics.pop()
        end
    end
end

function FlowMap:lookup(x, y)
    local col = math.floor(math.map(x, 0, width, 1, self.n) + 0.5)
    local row = math.floor(math.map(y, 0, height, 1, self.n) + 0.5)

    return self.field[col][row]:copy()
end