require 'player'
require 'ball'
require 'ai'
require 'background'

function love.load()
    Player:load()
    Ball:load()
    AI:load()
    Background:load()

    ai = AI.x
    score = {player=0,ai =0}
    font = love.graphics.newFont(20)
end

function love.update(dt)

    Player:update(dt)
    Ball:update(dt)
    AI:update(dt)
    Background:update(dt)
end

function love.draw()
    Background:draw()
    Player:draw()
    Ball:draw()
    AI:draw()
    drawScore()
end

function drawScore()
    love.graphics.setFont(font)
    love.graphics.print("Player :" ..score.player,50,50)
    love.graphics.print("AI :" ..score.ai,ai,50)

end

function checkCollision(a,b)
    if (a.x + a.width > b.x and a.x < b.x +b.width and a.y < b.y + b.height and a.y + a.height > b.y) then
        return true
    else
        return false
    end
end




