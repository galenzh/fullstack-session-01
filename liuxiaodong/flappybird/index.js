class Bird {
  constructor() {
    this.x = 30;
    this.y = 200;
    this.width = 34;  
    this.height = 24;
    this.dom = document.getElementById('bird');
    this.speed = 0;
    this.acceleration = 0.02;
    this.updatePosition();
    this.dom.addEventListener('animationend', () => {
      this.dom.style.display = 'none';
    });
  }

  updatePosition() {
    this.dom.style.transform = `translate(${this.x}px, ${this.y}px)`;
  }

  update(deltaTime) {
    this.speed += this.acceleration;
    this.y += this.speed * deltaTime;
    this.updatePosition();
  }

  jump() {
    this.speed = -0.4;
    wingSound.play();
  }
  
  reset() {
    this.y = 200;
    this.speed = 0;
    this.dom.style.display = 'block';
    this.updatePosition();
  }
}

class PipeUp {
  constructor() {
    this.x = 300;
    this.y = 420;
    this.width = 40;  
    this.height = 280;
    this.dom = document.getElementById('pipe-up');
    this.speed = -0.05;
    this.passed = false;
    this.updatePosition();
  }

  updatePosition() {
    this.dom.style.transform = `translate(${this.x}px , ${this.y}px)`;
  }

  update(deltaTime) {
    this.x += this.speed * deltaTime;
    if (this.x < -this.width ) { 
      this.random();
      this.passed = false;
    }
    this.updatePosition();
  }

  // 上管道的随机化需要依赖于下管道的位置，以保持间隙
  random(pipeDownY) {
    const minGap = 130;  // 上下管道的最小间隙
    this.x = 300;       
    this.y = pipeDownY + this.height + minGap;  // 基于下管道的位置生成
  }

  reset() {
    this.x = 300;
    this.passed = false;
    this.updatePosition();
  }
}

class PipeDown {
  constructor() {
    this.x = 300;
    this.y = -30;
    this.width = 40;  
    this.height = 280;
    this.dom = document.getElementById('pipe-down');
    this.speed = -0.05;
    this.updatePosition();
  }

  updatePosition() {
    this.dom.style.transform = `translate(${this.x}px , ${this.y}px)`;
  }

  update(deltaTime) {
    this.x += this.speed * deltaTime;
    if (this.x < -this.width) { 
      this.random();
    }
    this.updatePosition();
  }

  random() {
    this.x = 300;  // 让管道从屏幕右侧出现
    this.y = -200 + Math.random() * 140;  // 随机生成下管道的位置
  }

  reset() {
    this.x = 300;
    this.random();
    this.updatePosition();
  }
}

class Sky {
  constructor() {
    this.x = 0;
    this.y = 0;
    this.dom = document.getElementById('sky');
    this.speed = -0.01;
    this.updatePosition();
  }

  updatePosition() {
    this.dom.style.transform = `translate(${this.x}px , ${this.y}px)`;
  }

  update(deltaTime) {
    this.x += this.speed * deltaTime;
    if (this.x < -200) {
      this.x = 0;
    }
    this.updatePosition();
  }
}

class Land {
  constructor() {
    this.x = 0;
    this.speed = 1.2;
    this.dom = document.getElementById('land');
  }

  update() {
    this.x += this.speed;
    if (this.x > 200) {
      this.x = 0;
    }
    this.dom.style.transform = `translate(${-this.x}px)`;
  }
}

// 碰撞检测函数 - 优化碰撞检测算法
function checkCollision(bird, pipe) {
  // 获取小鸟的实际边界（稍微缩小以提供更好的游戏体验）
  const birdLeft = bird.x + 5;
  const birdRight = bird.x + bird.width - 5;
  const birdTop = bird.y + 5;
  const birdBottom = bird.y + bird.height - 5;
  
  // 获取管道的边界
  const pipeLeft = pipe.x;
  const pipeRight = pipe.x + pipe.width;
  const pipeTop = pipe.y;
  const pipeBottom = pipe.y + pipe.height;
  
  // 检查是否发生碰撞
  return (
    birdRight > pipeLeft &&
    birdLeft < pipeRight &&
    birdBottom > pipeTop &&
    birdTop < pipeBottom
  );
}

class Game {
  constructor() {
    this.bird = new Bird();
    this.sky = new Sky();
    this.land = new Land();
    this.pipeUp = new PipeUp();
    this.pipeDown = new PipeDown();
    this.counter = 0;
    this.gameState = 'start'; // 'start', 'playing', 'gameover'
    this.score = 0;
    this.highScore = this.getHighScore();
    
    this.gameStartScreen = document.getElementById('game-start');
    this.gameOverScreen = document.getElementById('game-over');
    
    // 初始设置
    this.setupInitialState();
    this.setupEventListeners();
  }
  
  setupInitialState() {
    // 设置初始状态
    this.bird.y = 200;
    this.bird.updatePosition();
    this.pipeDown.reset();
    this.pipeUp.reset();
    this.score = 0;
    this.updateScoreDisplay();
    
    // 显示开始界面
    this.gameStartScreen.style.display = 'flex';
    this.gameOverScreen.style.display = 'none';
  }
  
  setupEventListeners() {
    // 开始按钮点击事件
    document.querySelector('.start-button').addEventListener('click', () => {
      this.startGame();
    });
    
    // 重新开始按钮点击事件
    document.querySelector('.restart-button').addEventListener('click', () => {
      this.resetGame();
    });
    
    // 键盘控制
    document.addEventListener('keydown', event => {
      if (event.code === 'Space') {
        if (this.gameState === 'start') {
          this.startGame();
        } else if (this.gameState === 'playing') {
          this.bird.jump();
        } else if (this.gameState === 'gameover') {
          this.resetGame();
        }
      }
    });
    
    // 触摸屏幕控制（移动端支持）
    document.addEventListener('touchstart', () => {
      if (this.gameState === 'start') {
        this.startGame();
      } else if (this.gameState === 'playing') {
        this.bird.jump();
      } else if (this.gameState === 'gameover') {
        this.resetGame();
      }
    });
  }
  
  startGame() {
    this.gameState = 'playing';
    this.gameStartScreen.style.display = 'none';
    this.counter = 0;
    this.score = 0;
    this.updateScoreDisplay();
  }
  
  resetGame() {
    this.bird.reset();
    this.pipeDown.reset();
    this.pipeUp.random(this.pipeDown.y);
    this.gameState = 'playing';
    this.counter = 0;
    this.score = 0;
    this.updateScoreDisplay();
    this.gameOverScreen.style.display = 'none';
  }
  
  getHighScore() {
    return parseInt(localStorage.getItem('flappyBirdHighScore') || 0);
  }
  
  saveHighScore() {
    if (this.score > this.highScore) {
      this.highScore = this.score;
      localStorage.setItem('flappyBirdHighScore', this.highScore);
    }
  }
  
  updateScoreDisplay() {
    document.getElementById('score').textContent = this.score;
    document.getElementById('final-score').textContent = this.score;
    document.getElementById('high-score').textContent = this.highScore;
  }
  
  checkPassedPipe() {
    // 检查小鸟是否通过了管道（得分点）
    if (!this.pipeUp.passed && this.bird.x > this.pipeUp.x + this.pipeUp.width) {
      this.score++;
      this.pipeUp.passed = true;
      this.updateScoreDisplay();
      // 播放得分音效
      pointSound.play();
    }
  }

  update(deltaTime) {
    if (this.gameState !== 'playing') return;
    
    this.sky.update(deltaTime);
    this.land.update();
    this.bird.update(deltaTime);
    this.pipeUp.update(deltaTime);
    this.pipeDown.update(deltaTime);
    
    // 检查小鸟是否通过管道
    this.checkPassedPipe();

    // 当下管道更新位置时，同步更新上管道位置
    if (this.pipeDown.x === 300) {
      this.pipeUp.random(this.pipeDown.y);
    }

    // 碰撞检测
    if (checkCollision(this.bird, this.pipeUp) || 
        checkCollision(this.bird, this.pipeDown) || 
        this.bird.y > 370 || 
        this.bird.y < -10) {
      hitSound.play();
      crashSound.play();
      this.gameState = 'gameover';
      this.saveHighScore();
      this.updateScoreDisplay();
      this.gameOver();
    }

    this.counter++;
  }
  
  gameOver() {
    this.gameOverScreen.style.display = 'flex';
    this.birdFallToBottom();
  }
  
  // 小鸟下落到页面底部
  birdFallToBottom() {
    const fallInterval = setInterval(() => {
      if (this.bird.y < 375) {
        this.bird.y += 5; // 控制下落速度
        this.bird.updatePosition(); // 更新小鸟的位置
      } else {
        clearInterval(fallInterval); // 当小鸟到达底部时停止下落
      }
    }, 16); // 每16ms执行一次，实现平滑动画效果
  }
}

const game = new Game();
const hitSound = document.getElementById('hit');
const crashSound = document.getElementById('crash');
const wingSound = document.getElementById('wing');
const pointSound = document.getElementById('point');

let lastFrameTime = 0;
function mainLoop(currentTime) {
  let deltaTime = 0;
  if (lastFrameTime) {
    deltaTime = currentTime - lastFrameTime;
  }
  lastFrameTime = currentTime;

  game.update(deltaTime);
  requestAnimationFrame(mainLoop);
}

requestAnimationFrame(mainLoop);
