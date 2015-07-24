Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
}


var a = [1, 2, 3, 4];
a.myEach(function (el) {
  console.log(el);
})

Array.prototype.myMap = function (callback) {
  var result = [];
  this.myEach(function(el) {
    result.push(callback(el));
  });
  return result;
}

var b = a.myMap(function (el) {
  return el * 2;
})
console.log(b);

Array.prototype.myInject = function (callback) {
  var result = this[0];
  this.slice(1).myEach(function (el) {
    result = callback(result, el);
  });
  return result;
}

var c = a.myInject(function (accum, el) {
  return accum + el;
});
console.log(c);
