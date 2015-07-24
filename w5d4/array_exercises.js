function includes (array, el) {
  for (var i = 0; i < array.length; i++) {
    if (array[i] === el) {
      return true;
    };
  };
  return false;
};

Array.prototype.uniq = function () {
  var result = [];
  this.forEach( function (el) {
    if ( !includes(result, el) ) {
      result.push(el);
    };
  });
  return result;
};

array = [1, 2, 3, 3, 3, 5, 3];
console.log(array.uniq());


Array.prototype.twoSum = function () {
  var result = [];
  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i+1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        result.push([i,j]);
      };
    };
  };
  return result;
};


console.log([-1, 0, 2, -2, 1].twoSum());


Array.prototype.myTranspose = function () {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    result.push([]);
  };
  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[i].length; j++) {
      result[i][j] = this[j][i];
    };
  };
  return result;
};

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
console.log(rows.myTranspose());


var stockPicker = function (array) {
  var result = [];
  var diff = 0;
  for (var i = 0; i < array.length - 1; i++) {
    for (var j = i; j < array.length; j++) {
      if ( array[j] - array[i] > diff ) {
        diff = array[j] - array[i];
        result = [i, j];
      };
    };
  };
  return result;
};

var a = [5, 6, 39, 60, 45, 2, 50, 45, 24, 43];
console.log(stockPicker(a));
