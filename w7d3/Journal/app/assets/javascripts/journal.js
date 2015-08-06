window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var collection = new Journal.Collections.Posts();
    var postsIndex = new Journal.Views.PostsIndex({ collection: collection });
    $('#sidebar').html(postsIndex.render().$el);
    new Journal.Routers.Posts(collection);
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
