NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "" : "feedIndex",
    "feeds/new" : "feedForm",
    "feeds/:id" : "feedShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new NewsReader.Collections.Feeds();
  },

  feedIndex: function () {
    this.collection.fetch();
    var view = new NewsReader.Views.FeedIndex( {collection: this.collection} );
    this._swapView(view);
  },

  feedShow: function (id) {
    var feed = this.collection.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow({ model: feed });
    this._swapView(view);
  },

  feedForm: function () {
    var view = new NewsReader.Views.FeedForm({ collection: this.collection });
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._view && this._view.remove();
    this._view = newView;
    this.$rootEl.html( newView.render().$el );
  }
});
