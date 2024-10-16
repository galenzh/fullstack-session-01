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
}

class PipeUp {
  constructor() {
    this.x = 300;
    this.y = 420;
    this.width = 40;  
    this.height = 280;
    this.dom = document.getElementById('pipe-up');
    this.speed = -0.05;
    this.updatePosition();
  }

  updatePosition() {
    this.dom.style.transform = `translate(${this.x}px , ${this.y}px)`;
  }

  update(deltaTime) {
    this.x += this.speed * deltaTime;
    if (this.x < -this.width ) { 
      this.random();
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
    this.random(0);
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
    //console.log(this.x, -this.width);
    if (this.x < -this.width) { 
      console.log(this.x, -this.width);
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

// 碰撞检测函数
function checkCollision(bird, pipe) {
  return (
    bird.x < pipe.x + pipe.width &&  
    bird.x + bird.width > pipe.x &&  
    bird.y < pipe.y + pipe.height &&  
    bird.y + bird.height > pipe.y   
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
    this.isRunning = true;
    this.score = -1;
  }

  update(deltaTime) {
    this.sky.update(deltaTime);
    this.land.update();
    this.bird.update(deltaTime);
    this.pipeUp.update(deltaTime);
    this.pipeDown.update(deltaTime);

    // 当计数器到达一定值时，重新随机化管道位置
    if (this.counter % 400 === 0) {
      this.pipeDown.random();  // 先随机化下管道位置
      this.pipeUp.random(this.pipeDown.y);  // 基于下管道位置生成上管道
    }
    if (this.counter % 380 === 0) {
      this.score++;
    }
    document.getElementById('score').textContent = this.score;

    // 碰撞检测
    if (checkCollision(this.bird, this.pipeUp) || checkCollision(this.bird, this.pipeDown) || this.bird.y > 370) {
      hitSound.play();
      crashSound.play();
      this.isRunning = false; 
      this.birdFallToBottom();
    }

    this.counter++;
  }
}

// 小鸟下落到页面底部
Game.prototype.birdFallToBottom = function() {
  const fallInterval = setInterval(() => {
    if (this.bird.y < 375) {
      this.bird.y += 5; // 控制下落速度
      this.bird.updatePosition(); // 更新小鸟的位置
    } else {
      clearInterval(fallInterval); // 当小鸟到达底部时停止下落
    }
  }, 16); // 每16ms执行一次，实现平滑动画效果
};

const game = new Game();
const hitSound = document.getElementById('hit');
const crashSound = document.getElementById('crash');
const wingSound = document.getElementById('wing');

let lastFrameTime = 0;
function mainLoop(currentTime) {
  let deltaTime = 0;
  if (lastFrameTime) {
    deltaTime = currentTime - lastFrameTime;
  }
  lastFrameTime = currentTime;

  if (game.isRunning) {
    game.update(deltaTime);
  }

  requestAnimationFrame(mainLoop);
}

requestAnimationFrame(mainLoop);

document.addEventListener('keydown', event => {
  if (event.code === 'Space') {
    game.bird.jump();
  }
});
