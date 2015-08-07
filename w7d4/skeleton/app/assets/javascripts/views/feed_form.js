NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST['feeds/feed_form'],
  events: {
    'submit .new-feed' :'feedSubmit'
  },

  render: function(){
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    return this;
  },

  feedSubmit: function(e){
    e.preventDefault();
    var formData = $(e.currentTarget).serializeJSON();
    var newFeed = new NewsReader.Models.Feed(formData["feed"]);

    newFeed.save({}, {
      success: function () {
        this.collection.add(newFeed);
        Backbone.history.navigate("#/feeds/" + newFeed.id, { trigger: true });
      }.bind(this)
    });
  }
});
