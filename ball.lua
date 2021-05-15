Ball = {}

function Ball:load()
    self.img = love.graphics.newImage("assets/ball.png")
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.speed = 300
    self.xVel = -self.speed
    self.yVel = 0
end

function Ball:update(dt)
    self:move(dt)
    self:collide()
end

function Ball:move(dt)
    self.x = self.x + self.xVel*dt
    self.y = self.y + self.yVel*dt
end

--We need Collision Detection,
--We use AA_BB collision detection - time 3:40(down)
--https://www.youtube.com/watch?v=3CRIhC_2wTI&list=PL1A1gsSe2tMzxf54D1OooafEnADpjZlP7&index=4
--this is done in main.lua

function Ball:collide()
    self:collidePlayer()
    self:collideWall()
    self:CollideAI()
    self:score()
end

function Ball:collideWall()
    if self.y < 0 then
        self.y = 0;
        self.yVel = -self.yVel
    elseif self.y +self.height > love.graphics.getHeight() then
        self.y =  love.graphics.getHeight()  - self.height
        self.yVel = -self.yVel
 
    end
end

function Ball:collidePlayer()
    if checkCollision(self,Player) then
        self.xVel = self.speed
        local middleBall = self.y + (self.height)/2
        local middlePlayer = Player.y + (Player.height)/2
        local collisionPosition = middleBall - middlePlayer
        self.yVel = collisionPosition*5
    end
end

function Ball:CollideAI()
    if checkCollision(self,AI) then
        self.xVel = -self.speed
        local middleBall = self.y + (self.height)/2
        local middleAI = AI.y + (AI.height)/2
        local collisionPosition = middleBall - middleAI
        self.yVel = collisionPosition*5
    end
end

function Ball:score()
    if self.x < 0 then
        self:resetPosition(1)
        score.ai = score.ai + 1
    end

    if self.x + self.width > love.graphics.getWidth() then
        self:resetPosition(-1)
        score.player = score.player + 1
    end
end

function Ball:resetPosition(mod)
    
    self.x = love.graphics.getWidth()/2 - self.width /2
    self.y = love.graphics.getHeight()/2 - self.height /2 
    self.yVel = 0
    self.xVel = self.speed * mod
    
end

function Ball:draw()
    love.graphics.draw(self.img,self.x,self.y)
end