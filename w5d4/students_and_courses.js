function Student(options) {
  this.fname = options.fname;
  this.lname = options.lname;
  this.name = this.fname + this.lname;
  this.courses = [];
}

Student.prototype.enroll = function(course) {
  if (!includes(course.students, this)) {
    this.courses.forEach(function(enrolledCourse) {
      if (course.conflictsWith(enrolledCourse)) {
        throw "Conflicts with the current course.";
      }
    });
    this.courses.push(course);
    course.students.push(this);
  }
}

Student.prototype.courseLoad = function () {
  var res = {};
  this.courses.forEach(function(course) {
    res[course.dept] = res[course.dept] || 0;
    res[course.dept] += course.credits;
  })
  return res;
}

function Course(options) {
  this.name = options.name;
  this.dept = options.dept;
  this.credits = options.credits;
  this.timeBlock = options.timeBlock;
  this.days = options.days;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  if (!includes(student.courses, this)) {
    this.students.push(student);
    student.courses.push(this);
  }
}

Course.prototype.conflictsWith = function (course) {
  var conflict = false;
  var currentTimeBlock = this.timeBlock
  this.days.forEach(function (day) {
    if ( includes(course.days, day) && currentTimeBlock === course.timeBlock ) {
      conflict = true;
    }
  })
  return conflict;
};

function includes(array, target) {
  var include = false;
  array.forEach(function(el) {
    if (el === target) {
      include = true;
    }
  });
  return include;
}

var jesse = new Student( { fname: "Jesse", lname: "Latimer" } );
var mark = new Student( { fname: "Mark", lname: "Hao" } );
var javascript = new Course( { name: "Javascript 101", dept: "App Academy", credits: 4, timeBlock: 1, days: ["mon", "weds", "fri"] } );
var rails = new Course( { name: "Rails 101", dept: "App Academy", credits: 5, timeBlock: 1, days: ["mon", "weds", "fri"] } );
