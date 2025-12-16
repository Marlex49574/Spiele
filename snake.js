// Game configuration
const GRID_SIZE = 20;
const CELL_SIZE = 20;
const INITIAL_SPEED = 150;

// Game state
let canvas, ctx;
let snake = [];
let food = {};
let direction = 'right';
let nextDirection = 'right';
let score = 0;
let highscore = 0;
let gameLoop = null;
let isPaused = false;
let isGameOver = false;

// Initialize game
function init() {
    canvas = document.getElementById('gameCanvas');
    ctx = canvas.getContext('2d');
    
    // Load highscore from localStorage
    highscore = parseInt(localStorage.getItem('snakeHighscore')) || 0;
    updateScore();
    
    // Initialize game state
    resetGame();
    
    // Setup controls
    document.getElementById('startBtn').addEventListener('click', startGame);
    document.getElementById('pauseBtn').addEventListener('click', togglePause);
    document.getElementById('resetBtn').addEventListener('click', resetGame);
    
    // Keyboard controls
    document.addEventListener('keydown', handleKeyPress);
}

function resetGame() {
    // Stop any existing game loop
    if (gameLoop) {
        clearInterval(gameLoop);
        gameLoop = null;
    }
    
    // Reset game state
    snake = [
        { x: 10, y: 10 },
        { x: 9, y: 10 },
        { x: 8, y: 10 }
    ];
    direction = 'right';
    nextDirection = 'right';
    score = 0;
    isPaused = false;
    isGameOver = false;
    
    updateScore();
    spawnFood();
    draw();
}

function startGame() {
    if (gameLoop || isGameOver) {
        resetGame();
    }
    
    if (!gameLoop && !isPaused) {
        gameLoop = setInterval(update, INITIAL_SPEED);
    }
}

function togglePause() {
    if (!gameLoop) return;
    
    isPaused = !isPaused;
    if (isPaused) {
        clearInterval(gameLoop);
        gameLoop = null;
        drawPauseScreen();
    } else {
        gameLoop = setInterval(update, INITIAL_SPEED);
    }
}

function handleKeyPress(e) {
    const key = e.key.toLowerCase();
    
    // Prevent default for arrow keys
    if (['arrowup', 'arrowdown', 'arrowleft', 'arrowright'].includes(key)) {
        e.preventDefault();
    }
    
    // Direction controls
    if ((key === 'arrowup' || key === 'w') && direction !== 'down') {
        nextDirection = 'up';
    } else if ((key === 'arrowdown' || key === 's') && direction !== 'up') {
        nextDirection = 'down';
    } else if ((key === 'arrowleft' || key === 'a') && direction !== 'right') {
        nextDirection = 'left';
    } else if ((key === 'arrowright' || key === 'd') && direction !== 'left') {
        nextDirection = 'right';
    }
    
    // Space to pause
    if (key === ' ') {
        e.preventDefault();
        togglePause();
    }
}

function update() {
    if (isPaused || isGameOver) return;
    
    // Update direction
    direction = nextDirection;
    
    // Calculate new head position
    const head = { ...snake[0] };
    
    switch (direction) {
        case 'up':
            head.y--;
            break;
        case 'down':
            head.y++;
            break;
        case 'left':
            head.x--;
            break;
        case 'right':
            head.x++;
            break;
    }
    
    // Check wall collision
    if (head.x < 0 || head.x >= GRID_SIZE || head.y < 0 || head.y >= GRID_SIZE) {
        gameOver();
        return;
    }
    
    // Check self collision
    if (snake.some(segment => segment.x === head.x && segment.y === head.y)) {
        gameOver();
        return;
    }
    
    // Add new head
    snake.unshift(head);
    
    // Check food collision
    if (head.x === food.x && head.y === food.y) {
        score += 10;
        updateScore();
        spawnFood();
    } else {
        // Remove tail if no food eaten
        snake.pop();
    }
    
    draw();
}

function spawnFood() {
    let validPosition = false;
    
    while (!validPosition) {
        food = {
            x: Math.floor(Math.random() * GRID_SIZE),
            y: Math.floor(Math.random() * GRID_SIZE)
        };
        
        // Check if food spawns on snake
        validPosition = !snake.some(segment => segment.x === food.x && segment.y === food.y);
    }
}

function draw() {
    // Clear canvas
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    // Draw grid (optional, subtle)
    ctx.strokeStyle = '#111';
    ctx.lineWidth = 1;
    for (let i = 0; i <= GRID_SIZE; i++) {
        ctx.beginPath();
        ctx.moveTo(i * CELL_SIZE, 0);
        ctx.lineTo(i * CELL_SIZE, canvas.height);
        ctx.stroke();
        
        ctx.beginPath();
        ctx.moveTo(0, i * CELL_SIZE);
        ctx.lineTo(canvas.width, i * CELL_SIZE);
        ctx.stroke();
    }
    
    // Draw food
    ctx.fillStyle = '#ff0000';
    ctx.beginPath();
    ctx.arc(
        food.x * CELL_SIZE + CELL_SIZE / 2,
        food.y * CELL_SIZE + CELL_SIZE / 2,
        CELL_SIZE / 2 - 2,
        0,
        Math.PI * 2
    );
    ctx.fill();
    
    // Draw snake
    snake.forEach((segment, index) => {
        if (index === 0) {
            // Head
            ctx.fillStyle = '#4CAF50';
        } else {
            // Body
            ctx.fillStyle = '#45a049';
        }
        
        ctx.fillRect(
            segment.x * CELL_SIZE + 1,
            segment.y * CELL_SIZE + 1,
            CELL_SIZE - 2,
            CELL_SIZE - 2
        );
    });
}

function drawPauseScreen() {
    ctx.fillStyle = 'rgba(0, 0, 0, 0.7)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    ctx.fillStyle = '#fff';
    ctx.font = '30px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('PAUSIERT', canvas.width / 2, canvas.height / 2);
}

function gameOver() {
    isGameOver = true;
    clearInterval(gameLoop);
    gameLoop = null;
    
    // Update highscore
    if (score > highscore) {
        highscore = score;
        localStorage.setItem('snakeHighscore', highscore);
        updateScore();
    }
    
    // Draw game over screen
    ctx.fillStyle = 'rgba(0, 0, 0, 0.7)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    ctx.fillStyle = '#fff';
    ctx.font = '30px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('GAME OVER', canvas.width / 2, canvas.height / 2 - 20);
    
    ctx.font = '20px Arial';
    ctx.fillText('Punkte: ' + score, canvas.width / 2, canvas.height / 2 + 20);
}

function updateScore() {
    document.getElementById('score').textContent = score;
    document.getElementById('highscore').textContent = highscore;
}

// Start game when page loads
window.addEventListener('load', init);
