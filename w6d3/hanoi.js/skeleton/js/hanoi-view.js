(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.$viewTowers = $('.tower');
    this.render();
    this.firstTower = null;
    this.clickHandler();
  };

  View.prototype.clickTower = function ($tower) {
    var argTower = $tower.data('index');
    if (this.firstTower !== null){
      if (this.game.isValidMove(this.firstTower, argTower)) {
        this.game.move(this.firstTower, argTower);
        console.log(this.game.towers);
        if (this.game.isWon()) {
          this.$viewTowers.off("click");
          // Add end game display
        }
      } else {
        alert("Not a valid move!!!");
      }
      this.$viewTowers.eq(this.firstTower).removeClass("selected");
      this.firstTower = null;
    } else {
      this.firstTower = argTower;
      this.$viewTowers.eq(argTower).addClass("selected");
    }
  };

  View.prototype.clickHandler = function () {
    $('.tower').click(function(event) {
      var currentTarget = event.currentTarget;
      var $currentTarget = $(currentTarget);
      this.clickTower($currentTarget);
      this.render();
    }.bind(this));
  };

  View.prototype.render = function () {
    for (var i = 0; i < 3; i++) {
      var gameTower = this.game.towers[i];
      for (var j = 0; j < gameTower.length; j++) {
        var $viewDisc = $('.size' + (gameTower[j]));
        this.$viewTowers.eq(i).append($viewDisc);
      }
    }
  };

  View.prototype.setupTowers = function () {
    var $tower = $('<div class="tower"></div>');
    for (var i = 0; i < 3; i++) {
      this.$el.append($tower.clone().attr("data-index", i));
    }
    var $disc = $('<div class="disc"></div>');
    for (var j = 2; j >= 0; j--) {
      $("div.tower").eq(0).append($disc.clone().addClass('size' + (j + 1)));
    }

  };
})();
