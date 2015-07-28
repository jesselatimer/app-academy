(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Bullet = Asteroids.Bullet = function (pos, vel, game) {
    this.COLOR = "#39FF14";
    this.RADIUS = 5;
    this.startPos = pos;
    var args = { pos: pos, vel: vel,
                 color: this.COLOR, radius: this.RADIUS, game: game };
    Asteroids.MovingObject.call(this, args);
    this.isWrappable = false;
  };

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Asteroid) {
      this.game.remove(otherObject);
      this.game.remove(this);
    }
  };

})();
