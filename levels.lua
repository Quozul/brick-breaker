level = {}

brick = {}
bricksController = {}
bricksController.bricks = {}

function reset()
    plateau = {}
    plateau.x = love.mouse.getX()
    plateau.y = 500
    plateau.width = 60
    plateau.height = 10

    ball = {}
    ball.x = plateau.x + 1
    ball.y = 500
    ball.up = false
    ball.down = true
    ball.speedMultiplier = 4
    ball.angle = 0
    ball.radius = 4
    sounds.bwpitch = 1

    score = 0
    multiplieur = 1
    start = os.time()
    lastBreak = start
    brickCount = 0
    musicStarted = 1
    playMusic = true
    lastToggle = 5 
end

function level.one()
    -- haut gauche
    bricksController:spawnBrick(1, 3) -- Minimum
    bricksController:spawnBrick(2, 3)
    bricksController:spawnBrick(4, 3)
    bricksController:spawnBrick(5, 3)
    bricksController:spawnBrick(7, 3)
    bricksController:spawnBrick(8, 3)
    bricksController:spawnBrick(11, 3)
    bricksController:spawnBrick(12, 3)
    bricksController:spawnBrick(14, 3)
    bricksController:spawnBrick(15, 3)
    bricksController:spawnBrick(17, 3)
    bricksController:spawnBrick(18, 3)

    bricksController:spawnBrick(1, 4)
    bricksController:spawnBrick(2, 4)
    bricksController:spawnBrick(4, 4)
    bricksController:spawnBrick(5, 4)
    bricksController:spawnBrick(7, 4)
    bricksController:spawnBrick(8, 4)
    bricksController:spawnBrick(11, 4)
    bricksController:spawnBrick(12, 4)
    bricksController:spawnBrick(14, 4)
    bricksController:spawnBrick(15, 4)
    bricksController:spawnBrick(17, 4)
    bricksController:spawnBrick(18, 4)

    bricksController:spawnBrick(1, 6) -- New group
    bricksController:spawnBrick(2, 6)
    bricksController:spawnBrick(7, 6)
    bricksController:spawnBrick(8, 6)
    bricksController:spawnBrick(11, 6)
    bricksController:spawnBrick(12, 6)
    bricksController:spawnBrick(17, 6)
    bricksController:spawnBrick(18, 6)

    bricksController:spawnBrick(1, 7)
    bricksController:spawnBrick(2, 7)
    bricksController:spawnBrick(7, 7)
    bricksController:spawnBrick(8, 7)
    bricksController:spawnBrick(11, 7)
    bricksController:spawnBrick(12, 7)
    bricksController:spawnBrick(17, 7)
    bricksController:spawnBrick(18, 7)

    bricksController:spawnBrick(1, 9) -- New group
    bricksController:spawnBrick(2, 9)
    bricksController:spawnBrick(4, 9)
    bricksController:spawnBrick(5, 9)
    bricksController:spawnBrick(7, 9)
    bricksController:spawnBrick(8, 9)
    bricksController:spawnBrick(11, 9)
    bricksController:spawnBrick(12, 9)
    bricksController:spawnBrick(14, 9)
    bricksController:spawnBrick(15, 9)
    bricksController:spawnBrick(17, 9)
    bricksController:spawnBrick(18, 9)

    bricksController:spawnBrick(1, 10)
    bricksController:spawnBrick(2, 10)
    bricksController:spawnBrick(4, 10)
    bricksController:spawnBrick(5, 10)
    bricksController:spawnBrick(7, 10)
    bricksController:spawnBrick(8, 10)
    bricksController:spawnBrick(11, 10)
    bricksController:spawnBrick(12, 10)
    bricksController:spawnBrick(14, 10)
    bricksController:spawnBrick(15, 10)
    bricksController:spawnBrick(17, 10)
    bricksController:spawnBrick(18, 10)

    -- bricksController:spawnBrick(18, 20) -- Maximum
end

function level.two()
    -- haut gauche
    bricksController:spawnBrick(2, 3) -- Minimum
    bricksController:spawnBrick(3, 3)
    bricksController:spawnBrick(4, 3)
    bricksController:spawnBrick(5, 3)
    bricksController:spawnBrick(7, 3)
    bricksController:spawnBrick(8, 3)
    bricksController:spawnBrick(11, 3)
    bricksController:spawnBrick(12, 3)
    bricksController:spawnBrick(14, 3)
    bricksController:spawnBrick(15, 3)
    bricksController:spawnBrick(16, 3)
    bricksController:spawnBrick(17, 3)

    bricksController:spawnBrick(2, 4)
    bricksController:spawnBrick(3, 4)
    bricksController:spawnBrick(4, 4)
    bricksController:spawnBrick(5, 4)
    bricksController:spawnBrick(7, 4)
    bricksController:spawnBrick(8, 4)
    bricksController:spawnBrick(11, 4)
    bricksController:spawnBrick(12, 4)
    bricksController:spawnBrick(14, 4)
    bricksController:spawnBrick(15, 4)
    bricksController:spawnBrick(16, 4)
    bricksController:spawnBrick(17, 4)

    bricksController:spawnBrick(7, 6) -- New group
    bricksController:spawnBrick(8, 6)
    bricksController:spawnBrick(9, 6)
    bricksController:spawnBrick(10, 6)
    bricksController:spawnBrick(11, 6)
    bricksController:spawnBrick(12, 6)

    bricksController:spawnBrick(2, 7)
    bricksController:spawnBrick(3, 7)
    bricksController:spawnBrick(4, 7)
    bricksController:spawnBrick(5, 7)
    bricksController:spawnBrick(7, 7)
    bricksController:spawnBrick(8, 7)
    bricksController:spawnBrick(9, 7)
    bricksController:spawnBrick(10, 7)
    bricksController:spawnBrick(11, 7)
    bricksController:spawnBrick(12, 7)
    bricksController:spawnBrick(14, 7)
    bricksController:spawnBrick(15, 7)
    bricksController:spawnBrick(16, 7)
    bricksController:spawnBrick(17, 7)

    bricksController:spawnBrick(2, 8) -- New group
    bricksController:spawnBrick(3, 8)
    bricksController:spawnBrick(4, 8)
    bricksController:spawnBrick(5, 8)
    bricksController:spawnBrick(14, 8)
    bricksController:spawnBrick(15, 8)
    bricksController:spawnBrick(16, 8)
    bricksController:spawnBrick(17, 8)

    bricksController:spawnBrick(7, 9)
    bricksController:spawnBrick(8, 9)
    bricksController:spawnBrick(9, 9)
    bricksController:spawnBrick(10, 9)
    bricksController:spawnBrick(11, 9)
    bricksController:spawnBrick(12, 9)

    bricksController:spawnBrick(7, 10)
    bricksController:spawnBrick(8, 10)
    bricksController:spawnBrick(9, 10)
    bricksController:spawnBrick(10, 10)
    bricksController:spawnBrick(11, 10)
    bricksController:spawnBrick(12, 10)

    -- bricksController:spawnBrick(18, 20) -- Maximum
end

function level.three()
    bricksController:spawnBrick(2, 3)
    bricksController:spawnBrick(3, 3)
    bricksController:spawnBrick(4, 3)
    bricksController:spawnBrick(5, 3)
    bricksController:spawnBrick(6, 3)
    bricksController:spawnBrick(7, 3)
    bricksController:spawnBrick(8, 3)
    bricksController:spawnBrick(9, 3)
    bricksController:spawnBrick(10, 3)
    bricksController:spawnBrick(11, 3)
    bricksController:spawnBrick(12, 3)
    bricksController:spawnBrick(13, 3)
    bricksController:spawnBrick(14, 3)
    bricksController:spawnBrick(15, 3)
    bricksController:spawnBrick(16, 3)
    bricksController:spawnBrick(17, 3)

    bricksController:spawnBrick(2, 4)
    bricksController:spawnBrick(3, 4)
    bricksController:spawnBrick(4, 4)
    bricksController:spawnBrick(5, 4)
    bricksController:spawnBrick(6, 4)
    bricksController:spawnBrick(7, 4)
    bricksController:spawnBrick(8, 4)
    bricksController:spawnBrick(9, 4)
    bricksController:spawnBrick(10, 4)
    bricksController:spawnBrick(11, 4)
    bricksController:spawnBrick(12, 4)
    bricksController:spawnBrick(13, 4)
    bricksController:spawnBrick(14, 4)
    bricksController:spawnBrick(15, 4)
    bricksController:spawnBrick(16, 4)
    bricksController:spawnBrick(17, 4)

    bricksController:spawnBrick(9, 5)
    bricksController:spawnBrick(10, 5)

    bricksController:spawnBrick(2, 6)
    bricksController:spawnBrick(3, 6)
    bricksController:spawnBrick(9, 6)
    bricksController:spawnBrick(10, 6)
    bricksController:spawnBrick(16, 6)
    bricksController:spawnBrick(17, 6)

    bricksController:spawnBrick(2, 7)
    bricksController:spawnBrick(3, 7)
    bricksController:spawnBrick(9, 7)
    bricksController:spawnBrick(10, 7)
    bricksController:spawnBrick(16, 7)
    bricksController:spawnBrick(17, 7)

    bricksController:spawnBrick(9, 8)
    bricksController:spawnBrick(10, 8)

    bricksController:spawnBrick(2, 9)
    bricksController:spawnBrick(3, 9)
    bricksController:spawnBrick(4, 9)
    bricksController:spawnBrick(5, 9)
    bricksController:spawnBrick(6, 9)
    bricksController:spawnBrick(7, 9)
    bricksController:spawnBrick(8, 9)
    bricksController:spawnBrick(9, 9)
    bricksController:spawnBrick(10, 9)
    bricksController:spawnBrick(11, 9)
    bricksController:spawnBrick(12, 9)
    bricksController:spawnBrick(13, 9)
    bricksController:spawnBrick(14, 9)
    bricksController:spawnBrick(15, 9)
    bricksController:spawnBrick(16, 9)
    bricksController:spawnBrick(17, 9)

    bricksController:spawnBrick(2, 10)
    bricksController:spawnBrick(3, 10)
    bricksController:spawnBrick(4, 10)
    bricksController:spawnBrick(5, 10)
    bricksController:spawnBrick(6, 10)
    bricksController:spawnBrick(7, 10)
    bricksController:spawnBrick(8, 10)
    bricksController:spawnBrick(9, 10)
    bricksController:spawnBrick(10, 10)
    bricksController:spawnBrick(11, 10)
    bricksController:spawnBrick(12, 10)
    bricksController:spawnBrick(13, 10)
    bricksController:spawnBrick(14, 10)
    bricksController:spawnBrick(15, 10)
    bricksController:spawnBrick(16, 10)
    bricksController:spawnBrick(17, 10)
end
