(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Game = Asteroids.Game = function (dimX, dimY, numAsteroids) {
    this.over = false;
    this.DIM_X = dimX;
    this.DIM_Y = dimY;
    this.numAsteroids = numAsteroids;
    this.ship = new Asteroids.Ship([dimX/2, dimY/2], this);
    this.addAsteroids();
    this.allObjects = [this.ship].concat(this.asteroids);
  };

  Game.prototype.addAsteroids = function () {
    this.asteroids = [];
    var dims = [this.DIM_X, this.DIM_Y];
    for (var i = 0; i < this.numAsteroids; i++) {
      this.asteroids.push(new Asteroids.Asteroid(randoPos(dims), this));
    }
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    this.allObjects.forEach(function (object) { object.draw(ctx); });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects.forEach(function (object) { object.move(); });
  };

  Game.prototype.wrap = function (pos, radius) {
    return [wrapHelper(pos[0], this.DIM_X, radius),
            wrapHelper(pos[1], this.DIM_Y, radius)];
  };

  Game.prototype.checkCollisions = function () {
    for (var i = 0; i < this.allObjects.length; i++) {
      for (var j = i + 1; j < this.allObjects.length; j++) {
        if (this.allObjects[i].isCollidedWith(this.allObjects[j])) {
          this.allObjects[i].collideWith(this.allObjects[j]);
        }
      }
    }
  };

  Game.prototype.remove = function (object) {
    var objIdx = this.allObjects.indexOf(object);
    this.allObjects.splice(objIdx, 1);
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.isOutOfBounds = function (pos) {
    return (pos[0] > this.DIM_X || pos[0] < 0 ||
            pos[1] > this.DIM_Y || pos[1] < 0);
  };

  Game.prototype.gameOver = function () {
    this.over = true;
  };

  function wrapHelper(coord, max, radius) {
    if (coord - radius > max) { return 0 - radius; }
    if (coord + radius < 0) { return max + radius; }
    return coord;
  }

  function randoPos(dims){
    var x = Math.random() * dims[0];
    var y = Math.random() * dims[1];
    return [x, y];
  }

})();
