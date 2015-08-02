$.TweetCompose = function (el) {
  this.$el = $(el);

  this.$el.on('submit', this.submit.bind(this));
  this.$el.on('input', 'textarea', function (event) {
    var charsRemaining = (140 - event.currentTarget.value.length);
    this.$el.find('strong').text(charsRemaining + " characters remaining");
  }.bind(this));
  this.$el.on('click', '.add-mentioned-user', this.addMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function (event) {
  $('.mentioned-users').append($('#add-mention-script').html());
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();

  var formData = $(event.currentTarget).serialize();
  this.$el.find(':input').prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    dataType: "json",
    data: formData,
    success: function (tweet) {
      this.handleSuccess(tweet);
    }.bind(this),
    error: function () {
      console.log("Error in TweetCompose.submit");
    }
  });
};

$.TweetCompose.prototype.clearInput = function () {
  this.$el.find(':input').val('').removeAttr('selected');
};

$.TweetCompose.prototype.handleSuccess = function (tweet) {
  this.clearInput();
  this.$el.find(':input').prop("disabled", false);
  var $tweetsUl = $(this.$el.data('tweets-ul'));
  $tweetsUl.prepend($('<li>' + JSON.stringify(tweet) + '</li>'));
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $('.tweet-compose').tweetCompose();
});
