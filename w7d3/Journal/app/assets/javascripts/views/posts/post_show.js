Journal.Views.PostView = Backbone.View.extend({
  template: JST["posts/post"],
  events: {
    "click .delete-button": "deletePost",
    "dblclick .editable": "editField",
    "keypress .editable input": "dummy",
    "blur .editable": "updateField"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var template = this.template({ post: this.model });
    this.$el.html(template);
    return this;
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
  },

  editField: function (e) {
    var text = $(e.currentTarget).text();
    $(e.currentTarget).html('<input type="text" value="' + text + '">');
    $(e.currentTarget).find('input').focus();
  },

  updateField: function (e) {
    var newText = e.target.value;
    if (newText !== "") {
      $(e.currentTarget).text(newText);
    }
  },

  dummy: function (e) {
    if (e.keyCode === 13) {
      e.currentTarget.blur();
    }
  }
});
