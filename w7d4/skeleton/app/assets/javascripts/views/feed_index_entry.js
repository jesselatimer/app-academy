NewsReader.Views.FeedIndexEntry = Backbone.View.extend({
  template: JST["entries/feed_index_entry"],
  tagName: "li",

  events: {
    "click .hide-button" : "removeEntry"
  },

  render: function () {
    var renderedContent = this.template({ entry: this.model });
    this.$el.html(renderedContent);
    return this;
  },

  removeEntry: function () {
    this.remove();
  }
});
