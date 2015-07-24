function Cat(options) {
  this.name = options.name;
  this.owner = options.owner;
}

Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name;
};

var felix = new Cat( { name: "Felix", owner: "Magic Bag of Tricks" } );
var garfeild = new Cat( { name: "Garfield", owner: "Jon" } );
var warrior = new Cat( { name: "Warrior (really a dog)", owner: "Mark" } );

console.log(felix.cuteStatement())
console.log(garfeild.cuteStatement())
console.log(warrior.cuteStatement())

Cat.prototype.cuteStatement = function () {
  return "Everyone loves " + this.name;
};

console.log(felix.cuteStatement())
console.log(garfeild.cuteStatement())
console.log(warrior.cuteStatement())

Cat.prototype.meow = function () {
  return this.name + " says meow";
};

console.log(felix.meow())
console.log(garfeild.meow())
console.log(warrior.meow())

warrior.meow = function () {
  return this.name + " says bark";
}

console.log(felix.meow())
console.log(garfeild.meow())
console.log(warrior.meow())
