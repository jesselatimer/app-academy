$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$ul = this.$el.find('.users');

  this.$input.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  $.ajax({
    dataType: "json",
    data: { query: this.$input.val() },
    url: "/users/search",
    type: "GET",
    success: function (users) {
      this.renderResults(users);
    }.bind(this),
    error: function () {
    }
  });
};

$.UsersSearch.prototype.renderResults = function (users) {
  this.$ul.empty();
  users.forEach(function (user) {
    var newEl = $('<li></li>');
    newEl.append($('<a href="/users/' + user.id + '/">' + user.username + '</a>'));
    var newButton = ($('<button class="follow-toggle">'));
    var followState = user.followed ? "followed" : "unfollowed";
    newButton.followToggle({ userId: user.id, followState: followState });
    newEl.append(newButton);
    this.$ul.append(newEl);
  }.bind(this));
};

$.fn.usersSearch = function () {
  return this.each( function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $('div.users-search').usersSearch();
});
