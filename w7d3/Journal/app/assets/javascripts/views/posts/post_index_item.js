Journal.Views.PostsIndexItem = Backbone.View.extend({
  tagName: "li",
  template: JST["posts/index_item"],
  events: {
    "click .delete-button": "deletePost"
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
  },

  render: function () {
    var template = this.template({ post: this.model });
    this.$el.html(template);
    return this;
  }
});
