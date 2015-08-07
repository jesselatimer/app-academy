window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new NewsReader.Routers.NewsRouter( {$rootEl: $('#content') });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
