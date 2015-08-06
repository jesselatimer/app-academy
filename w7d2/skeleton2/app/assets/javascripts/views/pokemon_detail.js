Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemonDetail'],

  events: {
    "click li" : "selectToyFromList"
  },

  initialize: function (pokemon) {
    this.pokemon = pokemon;

    this.listenTo(this.pokemon, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({ pokemon: this.pokemon });
    this.$el.html(renderedContent);
    var that = this;

    this.pokemon.toys().each(function(toy){
      var toyTemplate = JST['toyListItem']({toy: toy});
      that.$el.append(toyTemplate);
    });

    return this;
  },

  selectToyFromList: function(e) {
    var toyId = $(e.currentTarget).data("toy-id");
    Backbone.history.navigate("/pokemon/" + this.pokemon.id +
                              "/toys/" + toyId, { trigger: true });
  }
});
