$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id') || options.userId;
  this.followState = this.$el.data('initial-follow-state') || options.followState;

  this.render();

  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  switch (this.followState) {
    case "followed":
      this.$el.prop("disabled", false);
      this.$el.text("Unfollow!");
      break;
    case "unfollowed":
      this.$el.prop("disabled", false);
      this.$el.text("Follow!");
      break;

    case "following":
      this.$el.prop("disabled", true);
      break;
    case "unfollowing":
      this.$el.prop("disabled", true);
      break;
    default:
      throw "Invalid follow state";
  }
};

$.FollowToggle.prototype.toggleFollowState = function () {
  switch (this.followState) {
    case "followed":
      this.followState = "unfollowing";
      break;
    case "unfollowing":
      this.followState = "unfollowed";
      break;
    case "unfollowed":
      this.followState = "following";
      break;
    case "following":
      this.followState = "followed";
      break;
    default:
      throw "Invalid follow state";
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  // var formData = $(this).serialize();
  // console.log(formData);
  var method;

  if (this.followState === 'unfollowed') {
    method = "POST";
  } else {
    method = "DELETE";
  }

  this.toggleFollowState();
  this.render();

  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: method,
    data: {user_id: this.userId},
    dataType: "json",
    success: function () {
      this.toggleFollowState();
      this.render();
    }.bind(this),
    error: function () {
      console.log("Error in FollowToggle");
    }
  });
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
