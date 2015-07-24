function bubbleSort(array) {
  var unsolved = true;
  do {
    unsolved = false;
    for (var i = 0; i < array.length - 1; i++) {
      if ( array[i] > array[i + 1]) {
        var temp = array[i];
        array[i] = array[i + 1];
        array[i + 1] = temp;
        unsolved = true;
      }
    }
  } while ( unsolved );
  return array;
}

console.log(bubbleSort([4, 5, 6, 3, 6, 5]));


function subStrings(string) {
  var result = [];
  for (var i = 0; i < string.length; i++) {
    for (var j = i + 1; j <= string.length; j++) {
      result.push(string.slice(i,j));
    }
  }
  return result;
}

console.log(subStrings("cat"));
console.log(subStrings("puppy"));
