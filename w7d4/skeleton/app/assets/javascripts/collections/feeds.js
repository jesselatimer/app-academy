NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: "/api/feeds",

  getOrFetch: function(id) {
    var model;
    if (this.get(id)){
      model = this.get(id);
      model.fetch();
    } else {
      model = new NewsReader.Models.Feed( {id: id} );
      model.fetch( { success: function () {
        this.add(model);
      }.bind(this) });
    }
    return model;
  }
});
