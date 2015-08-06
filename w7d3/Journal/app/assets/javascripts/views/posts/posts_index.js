Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync remove reset", this.render);
  },

  render: function () {
    var template = this.template({ collection: this.collection });
    this.$el.html(template);
    this.$el.append($('<ul>'));
    this.collection.each(function(post) {
      var li = new Journal.Views.PostsIndexItem( { model: post });
      this.$('ul').append(li.render().$el);
    }.bind(this));
    return this;
  }

});
