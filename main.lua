require("levels")

brick = {}
bricksController = {}
bricksController.bricks = {}

bonus = {}
bonusController = {}
bonusController.bonuses = {}

function love.load()
    sounds = {}
    sounds.bp = love.audio.newSource( "data/b-p.ogg", "stream" ) -- When the ball hit the plateau
    sounds.bw = love.audio.newSource( "data/b-w.ogg", "stream" ) -- When the ball hits a wall
    sounds.bb = love.audio.newSource( "data/b-b.ogg", "stream" ) -- When the ball breaks a brick
    sounds.go = love.audio.newSource( "data/g-o.ogg", "stream" ) -- Game over
    sounds.nb = love.audio.newSource( "data/nb.ogg", "stream" ) -- Negative bonus
    sounds.pb = love.audio.newSource( "data/pb.ogg", "stream" ) -- Positive bonus
    sounds.music = love.audio.newSource( "data/music.ogg", "stream" ) -- Positive bonus

    --levelImages = {}
    --levelImages.one = love.graphics.newImage("data/level_one.png")

    width, height, flags = love.window.getMode()
    love.mouse.setVisible(false)
    love.window.setTitle("Brick-breaker")
    icon = love.graphics.newImage("data/icon.png")
    love.window.setIcon(icon:getData())

    currentLevel = 1
    reset()
    level.one()

    --createBrick(60, love.math.random(1, 5))
    totalBrickCount = brickCount
end

function createBrick(startingLine, lines)
    i = 1
    n = startingLine
    e = lines * 40 + n

    while n <= e do
        bricksController:spawnBrick(40 * i, n)
        i = i + 1
        if i > 18 then
            i = 1
            n = n + 40
        end
    end
end

function removeBrick()
    for i, e in ipairs(bricksController.bricks) do
        if ( ball.x + ball.radius >= e.x and ball.x - ball.radius <= e.x + e.width and ball.y + ball.radius >= e.y and ball.y - ball.radius <= e.y + e.height ) then
            table.remove(bricksController.bricks, i)
            brickCount = brickCount - 1
            love.audio.stop(sounds.bb)
            love.audio.play(sounds.bb)
            if os.time() - lastBreak <= 2 and multiplieur <= 3 and canMultiply then
                multiplieur = multiplieur + 1
            end
            if canResetMultiplyTimer or canMultiply then lastBreak = os.time() end
            score = score + e.r * multiplieur

            if ball.y - ball.radius >= e.y and ball.y >= e.y + e.height then
                ball.up = false
                ball.down = true
            elseif ball.y + ball.radius <= e.y + e.height and ball.y <= e.y + e.height then
                ball.up = true
                ball.down = false
            end
            if ball.x + ball.radius >= e.x and ball.x - ball.radius <= e.x and ball.angle >= 0 then
                ball.angle = -ball.angle
            elseif ball.x - ball.radius <= e.x + e.width and ball.x + ball.radius >= e.x + e.width and ball.angle < 0 then
                ball.angle = -ball.angle
            end

            if e.haveBonus then
                bonusController:spawnBonus(e.x + e.width / 2, e.y + e.height / 2, e.type)
            end
        end
    end
end

function bonusController:spawnBonus(x, y, type)
    bonus = {}
    bonus.x = x
    bonus.y = y
    bonus.ix = x
    bonus.type = type
    table.insert(self.bonuses, bonus)
end

function bricksController:spawnBrick(x, y)
    brick = {}
    brick.x = x * 40 + 5
    brick.y = y * 20
    brick.width = 30
    brick.height = 15
    brick.r = love.math.random(1, 16)
    if love.math.random(0, 100) <= 20 then
        brick.haveBonus = true
        brick.type = love.math.random(0, 5)
    else
        brick.haveBonus = false
    end
    table.insert(self.bricks, brick)
    brickCount = brickCount + 1
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function love.update(dt)
    if love.keyboard.isDown("f11") then love.window.setFullscreen(true) end
    if love.keyboard.isDown("m") and playMusic and lastToggle >= 50 then
        playMusic = false
        lastToggle = 0
    elseif love.keyboard.isDown("m") and not playMusic and lastToggle >= 50 then
        playMusic = true
        lastToggle = 0
    end
    lastToggle = lastToggle + 1

    if love.timer.getTime() - musicStarted >= 1.776 and playMusic then
        love.audio.rewind(sounds.music)
        love.audio.play(sounds.music)
        musicStarted = love.timer.getTime()
    elseif not playMusic then
        love.audio.stop(sounds.music)
    end
    if love.keyboard.isDown("escape") then love.event.quit() end

    if love.mouse.isDown(1) and gameOver then
        while tablelength(bricksController.bricks) > 0 do
            for i, e in ipairs(bricksController.bricks) do
                    table.remove(bricksController.bricks, i)
            end
        end
        while tablelength(bonusController.bonuses) > 0 do
            for i, e in ipairs(bonusController.bonuses) do
                    table.remove(bonusController.bonuses, i)
            end
        end
        reset()
        gameOver = false

        if currentLevel == 2 then
            level.two()
        elseif currentLevel == 3 then
            level.three()
        else
            level.one()
        end
        totalBrickCount = brickCount
    end

    if brickCount <= 0 and not gameOver then
        gameOver = true
        currentLevel = currentLevel + 1
        love.audio.play(sounds.go)
    end

    for i,b in ipairs(bonusController.bonuses) do
        b.y = b.y + 2
        if ( b.y >= plateau.y and b.y <= plateau.y + plateau.height and b.x >= plateau.x and b.x <= plateau.x + plateau.width ) then

            table.remove(bonusController.bonuses, i)

            if b.type == 0 and plateau.width < 120 then                                  -- Plateau large
                plateau.width = plateau.width + 10
            elseif b.type == 1 and ball.radius < 8 then                               -- Grosse balle
                ball.radius = ball.radius + 2
                sounds.bwpitch = sounds.bwpitch - 0.1
                sounds.bw:setPitch(sounds.bwpitch)
            elseif b.type == 2 then                              -- Points x2
                lastBreak = os.time() + 10
                multiplieur = multiplieur * 2
                canResetMultiplyTimer = false
            elseif b.type == 3 and ball.radius - 2 > 1 then                              -- Petite balle
                ball.radius = ball.radius - 2
                sounds.bwpitch = sounds.bwpitch + 0.1
                sounds.bw:setPitch(sounds.bwpitch)
            elseif b.type == 4 then                              -- Petit plateau
                plateau.width = plateau.width - 10
            elseif b.type == 5 then                              -- Points x0
                lastBreak = os.time() + 15
                multiplieur = 0
                canMultiply = false
            end

            if b.type > 2 then
                love.audio.stop(sounds.nb)
                love.audio.play(sounds.nb)
            else
                love.audio.stop(sounds.pb)
                love.audio.play(sounds.pb)
            end

        end

        if b.y >= 575 then table.remove(bonusController.bonuses, i) end
    end

    if not gameOver then
        if love.mouse.getX() - plateau.width / 2 >= 10 and love.mouse.getX() + plateau.width / 2 <= 790 then
            plateau.x = love.mouse.getX() - plateau.width / 2
        elseif love.mouse.getX() <= 10 or plateau.x <= 10 then
            plateau.x = 10
        elseif love.mouse.getX() >= 790 or plateau.x + plateau.width >= 790 then
            plateau.x = 790 - plateau.width
        end
        love.mouse.setY( plateau.y + plateau.height / 2 )
        --if ball.y >= 450 and ball.down then
        --    love.mouse.setX(ball.x + plateau.width / 2 - 10)
        --else
        --    for _,b in pairs(bonusController.bonuses) do
        --        if b.type <= 3 and plateau.y - b.y < 10 then
        --            love.mouse.setX(b.x)
        --        end
        --    end
        --end
    else
        love.mouse.setX(ball.x + 10)
        plateau.x = love.mouse.getX() - plateau.width / 2
    end

    if os.time() - lastBreak >= 2 then
        multiplieur = 1
        canResetMultiplyTimer = true
        canMultiply = true
    end
    removeBrick()

    -- when ball hits the plateau
    if ( ball.y + ball.radius >= plateau.y and ball.y - ball.radius <= plateau.y + plateau.height and ball.x + ball.radius >= plateau.x and ball.x - ball.radius <= plateau.x + plateau.width ) then
        ball.up = true
        ball.down = false
        ball.angle = ( ball.x - (plateau.x + plateau.width / 2) ) / 4
        love.audio.play(sounds.bp)
    end

    ball.speed = 1

    if ball.y <= 575 and ball.up then
        ball.y = ball.y - ball.speed * ball.speedMultiplier
        ball.x = ball.x + ball.angle
    elseif ball.y <= 575 and ball.down then
        ball.y = ball.y + ball.speed * ball.speedMultiplier
        ball.x = ball.x + ball.angle
    elseif ball.y + ball.radius >= 575 then
        gameOver = true
        love.audio.play(sounds.go)
    end

    if ball.x - ball.radius <= 10 then
        ball.angle = -ball.angle
        ball.x = ball.x + 1
        love.audio.stop(sounds.bw)
        love.audio.play(sounds.bw)
    elseif ball.x + ball.radius >= 790 then
        ball.angle = -ball.angle
        ball.x = ball.x - 1
        love.audio.stop(sounds.bw)
        love.audio.play(sounds.bw)
    end

    if ball.y - ball.radius <= 40 then
        ball.up = false
        ball.down = true
        love.audio.stop(sounds.bw)
        love.audio.play(sounds.bw)
    end
end

function love.draw()
    love.graphics.setBackgroundColor(55, 61, 72)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 10 + 2, 40 - 2, 780, 535)
    love.graphics.setColor(225, 228, 231)
    love.graphics.rectangle("fill", 10, 40, 780, 535)

    love.graphics.setColor(255, 255, 255)
    --love.graphics.draw(levelImages.one, width / 2 - 64 / 2, height / 2 - 163 / 2)

    if not gameOver then
        love.graphics.print("Score: " ..score.. "  Multiplier: " ..multiplieur.. "  Last destruction: " ..os.time() - lastBreak.. "  Time: " ..os.time() - start.. " seconds  Bricks destroyed: " ..totalBrickCount - brickCount.. " of " ..totalBrickCount, 10, 10 )
        time = (os.time() - start) / 100
    else
        love.graphics.print("Game over  ;  Score: score / (temps / 100) = " ..score.. " / " ..time.. " = " ..score / time , width / 4, height / 2) -- Game over
    end

    love.graphics.setColor(41, 48, 58, 50)
    love.graphics.rectangle("fill", plateau.x - 2, plateau.y + 2, plateau.width, plateau.height ) -- Affiche le plateau
    love.graphics.setColor(82, 148, 226)
    love.graphics.rectangle("fill", plateau.x, plateau.y, plateau.width, plateau.height ) -- Affiche le plateau

    love.graphics.setColor(41, 48, 58)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius ) -- Affiche la balle

    love.graphics.setColor(255, 55, 55)
    love.graphics.line(0, 575, 800, 575) -- Dead-line

    -- Affiche les briques
    for _,b in pairs(bricksController.bricks) do
        love.graphics.setColor(41, 48, 58, 50)
        love.graphics.rectangle("fill", b.x - 2, b.y + 2, b.width, b.height)
        if not b.haveBonus then
            love.graphics.setColor(2, 119, 189)
        elseif b.type > 2 then
            love.graphics.setColor(204, 87, 93)
        elseif b.type <= 2 then
            love.graphics.setColor(192, 202, 51)
        end
        love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)
    end

    -- Affiche les bonus
    for _,b in pairs(bonusController.bonuses) do
        if b.type > 2 then
            love.graphics.setColor(204, 87, 93)
        else
            love.graphics.setColor(192, 202, 51 )
        end
        love.graphics.circle("fill", b.x, b.y, 4)
    end

    love.graphics.print("Game created by Quôzul", width - 160, height - 20)
end
