(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    var dx = randoVelocity();
    var dy = randoVelocity();
    this.COLOR = "white";
    this.RADIUS = 15;
    var args = { pos: pos, vel: [dx, dy],
                 color: this.COLOR, radius: this.RADIUS, game: game };
    Asteroids.MovingObject.call(this, args);
  }

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  function randoVelocity() {
    return Math.random() * 2 - 1;
  }

})();
