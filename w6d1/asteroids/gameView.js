(function (){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var GameView = Asteroids.GameView = function (game, canvas, gameOverScreen) {
    this.game = game;
    this.ctx = canvas.getContext("2d");
    this.gameOverScreen = gameOverScreen;
  };

  GameView.prototype.start = function () {
    var that = this;
    var interval = setInterval(function() {
      that.bindKeyHandlers();
      that.game.step.call(that.game);
      if (that.game.over === true) {
        that.ctx.drawImage(that.gameOverScreen, 0, 0,
                           that.game.DIM_X, that.game.DIM_Y);
      } else {
        that.game.draw.call(that.game, that.ctx);
      }
    }, 1000 / 60);
  };

  GameView.prototype.bindKeyHandlers = function () {
    if(key.isPressed("up")){ this.game.ship.power([0, -0.2]); }
    if(key.isPressed("down")){ this.game.ship.power([0, 0.2]); }
    if(key.isPressed("left")){ this.game.ship.power([-0.2, 0]); }
    if(key.isPressed("right")){ this.game.ship.power([0.2, 0]); }
    if(key.isPressed("space")){ this.game.ship.fireBullet(); }
  };

})();
