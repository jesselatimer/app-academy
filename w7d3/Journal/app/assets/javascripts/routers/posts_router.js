Journal.Routers.Posts = Backbone.Router.extend({
  routes: {
    ""               : "root",
    "posts/new"      : "showPostForm",
    "posts/:id"      : "showPost",
    "posts/:id/edit" : "showPostForm"
  },

  initialize: function (collection) {
    this.collection = collection;
    this.collection.fetch({ reset: true });
  },

  root: function () {
    this._view && this._view.remove();
  },

  showPost: function (id) {
    var post = this.collection.getOrFetch(id);
    var view = new Journal.Views.PostView({model: post});
    this.swap(view);
  },

  showPostForm: function (id) {
    var post = this.collection.getOrFetch(id);
    var view = new Journal.Views.PostForm({model: post});

    this.swap(view);
  },

  swap: function (newView) {
    this._view && this._view.remove();
    this._view = newView;
    $('#content').html(newView.render().$el);
  }
});
