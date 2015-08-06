Journal.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  events: {
    "submit form": "createPost"
  },

  render: function () {
    var template = this.template({ post: this.model });
    this.$el.html(template);
    return this;
  },

  createPost: function (e) {
    e.preventDefault();

    var formData = this.$('form').serializeJSON();
    this.model.save(formData, {
      success: function (post) {
        Backbone.history.navigate("#posts/" + post.id, {trigger: true});
      }.bind(this),

      error: function (post, errors) {
        console.log(errors);
        this.$el.prepend('<ul class="errors">');
        // doesn't replace error messages
        this.$(".errors").html(errors.responseText);
      }.bind(this)
    });
  }
});
