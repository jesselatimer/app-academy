NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["feeds/feed_show"],

  events: {
    "click .refresh-button" : "refresh",
    "click .delete-button" : "delete"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntryView);
    this.listenTo(this.model.entries(), "remove", this.removeEntryView);
    this.model.entries().each(this.addEntryView.bind(this));
  },

  render: function () {
    var renderedContent = this.template({ feed: this.model });
    this.$el.html(renderedContent);
    this.attachSubviews();
    return this;
  },

  addEntryView: function (entry){
    var subview = new NewsReader.Views.FeedIndexEntry({ model: entry} );
    this.addSubview('.entries', subview);
  },

  removeEntryView: function (entry) {
    this.removeModelSubview('.entries', entry);
  },

  refresh: function () {
    this.model.fetch({ url: "/api/feeds/" + this.model.id + "/reload" });
  },

  delete: function () {
    this.model.destroy();
    this.remove();
    Backbone.history.navigate('', { trigger:true });
  }
});
