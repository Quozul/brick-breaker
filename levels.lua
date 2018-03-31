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
    ball.verticalSpeed = 4
    ball.horizontalSpeed = 0
    ball.radius = 4
    sounds.bwpitch = 1

    ball.speed = 4

    score = 0
    multiplieur = 1
    start = os.time()
    lastBreak = start
    brickCount = 0
    musicStarted = 1
    playMusic = false
    lastToggle = 5
end

function level.one()
    local bricks = love.math.random(10, 100)
    for i=1,bricks do
        bricksController:spawnBrick(love.math.random(1, 18), love.math.random(3, 10))
    end
end
