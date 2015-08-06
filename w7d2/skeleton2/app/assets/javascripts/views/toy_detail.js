Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST["toyDetail"],

  initialize: function(toy) {
    this.toy = toy;

    this.listenTo(this.toy, "sync", this.render);
  },

  render: function() {
    var renderedContent = this.template({ toy: this.toy, pokemon: [] });
    this.$el.html(renderedContent);
    return this;
  }

});
