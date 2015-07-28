(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Ship = Asteroids.Ship = function (pos, game) {
    this.lives = 5;
    this.fireable = true;
    this.COLOR = "#39FF14";
    this.RADIUS = 15;
    this.startPos = pos;
    var args = { pos: pos, vel: [0, 0],
                 color: this.COLOR, radius: this.RADIUS, game: game };
    Asteroids.MovingObject.call(this, args);
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.collideWith = function (otherObject) {
    this.game.remove(otherObject);
    this.lives--;
    if (this.lives === 0) { this.game.gameOver(); }
    this.relocate();
  };

  Ship.prototype.relocate = function () {
    this.pos = this.startPos;
    this.vel = [0, 0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    var that = this;
    if (this.fireable === true) {
      this.fireable = false;
      setTimeout(function() {that.fireable = true;}, 500);
      var bulletVel = this.vel.slice(0);
      bulletVel[0] *= 2;
      bulletVel[1] *= 2;
      var bullet = new Asteroids.Bullet(this.pos.slice(0), bulletVel, this.game);
      this.game.allObjects.unshift(bullet);
    }
  };

})();
