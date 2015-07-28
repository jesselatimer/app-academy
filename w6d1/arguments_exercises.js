function sum() {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

Function.prototype.myBind = function (context) {
  var that = this;
  var args = [].slice.call(arguments, 1);

  return function() {
    args = args.concat([].slice.call(arguments));
    return that.apply(context, args);
  };
};

Function.prototype.myCurry = function (numCurries) {
  var curries = [];
  var that = this;
  return function _myCurry(curr) {
    curries.push(curr);
    if (curries.length === numCurries) { return that.apply(that, curries); }
    return _myCurry;
  };
};
