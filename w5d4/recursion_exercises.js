function range(start,end) {
  if ( end < start ) {
    return [];
  }
  var res = range(start, end - 1);
  res.push(end);
  return res;
}

console.log(range(5,8));


function sum(array) {
  if ( array.length === 1 ) {
    return array[0];
  }
  return sum(array.slice(1)) + array[0];
}

var a = [1, 2, 3, 4];
console.log(sum(a));

function exponentOne(n, base) {
  if ( n === 0 ) {
    return 1;
  }
  return base * exponent(n-1, base);
}

function exponentTwo(n, base) {
  if (n === 0) {
    return 1;
  } else if (n === 1) {
    return base;
  } else if (n % 2 === 0) {
    return Math.pow((exponentTwo(n / 2, base)), 2);
  } else {
    return base * Math.pow((exponentTwo((n - 1) / 2, base)), 2);
  }
}

console.log(exponentTwo(3,2));


function fibonacci(n) {
  if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  } else {
    var res = fibonacci(n - 1);
    res.push(res[res.length - 1] + res[res.length - 2]);
    return res;
  }
}

console.log(fibonacci(7));

function binarySearch(array, target) {
  var mid = Math.floor(array.length / 2);
  if ( array.length === 0 ) {
    return null;
  } else if ( array.length === 1 && array[0] !== target ) {
    return null;
  } else if ( array[mid] === target ) {
    return mid;
  } else if ( array[mid] > target ) {
    return binarySearch(array.slice(0, mid), target);
  } else if ( array[mid] < target ) {
    var res = binarySearch(array.slice(mid + 1, array.length), target);
    if (res === null) {
      return null;
    } else {
      return mid + 1 + res;
    }
  }
}

var a = [1, 2, 4, 5, 6, 9, 10];
console.log(binarySearch(a, 4));



function makeChangeOne(num,coins) {
  if ( num < coins[coins.length -1] ) {
    return [];
  } else if ( num >= coins[0] ) {
    var res = makeChange(num - coins[0], coins);
    console.log(res)
    res.push(coins[0]);
    return res;
  } else if ( num < coins[0] ) {
    return makeChange(num, coins.slice(1));
  } else {
    debugger;
  }
}


function makeChangeTwo(num, coins) {
  if ( num < coins[coins.length - 1] ) {
    return [];
  }
  var bestCoinIndex = null;
  var bestCoins = null;
  for (var i = 0; i < coins.length; i++) {
    if ( num >= coins[i] ) {
      var currentCoin = makeChangeTwo(num - coins[i], coins.slice(i));
      if ( bestCoins === null || bestCoins.length > currentCoin.length) {
        bestCoinIndex = i;
        bestCoins = currentCoin;
      }
    }
  }
  bestCoins.push(coins[bestCoinIndex]);
  return bestCoins;
}

console.log(makeChangeTwo(28,[15,10,7,1]));



function merge_sort(array) {
  if ( array.length === 0 ) {
    return [];
  } else if ( array.length === 1 ) {
    return array;
  } else {
    var mid = Math.floor(array.length / 2);
    var left = array.slice( 0, mid );
    var right = array.slice( mid, array.length );
    return merge(merge_sort(left),merge_sort(right));
  }
}


function merge(left, right) {
  var merged = [];
  while (left.length > 0 && right.length > 0) {
    if (left[0] > right[0]) {
      merged.push(right[0]);
      right = right.slice(1);
    } else if (right[0] >= left[0]) {
      merged.push(left[0]);
      left = left.slice(1);
    } else {
      debugger;
    }
  }
  merged = merged.concat(left).concat(right);
  return merged;
}

a = [4, 5, 6, 3, 6, 5];
console.log(merge_sort(a));


function subsets(array) {
  if ( array.length === 0 ) {
    return [[]];
  } else {
    var res = subsets(array.slice(1));
    var temp = [];
    res.forEach(function(el) {
      temp.unshift([array[0]].concat(el));
    })
    return temp.concat(res);
  }
}

console.log(subsets([1, 2, 3]));
