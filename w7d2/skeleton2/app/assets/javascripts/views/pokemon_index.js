Pokedex.Views.PokemonIndex = Backbone.View.extend({

  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    this.$el.empty();
    this.collection.each(this.addPokemonToList.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var template = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(template);
  },

  refreshPokemon: function(callback) {
    this.collection.fetch({
      success: callback
    });
  },

  selectPokemonFromList: function(e) {
    var pokeId = $(e.currentTarget).data("id");
    Backbone.history.navigate('/pokemon/' + pokeId, { trigger: true });
  }
});
