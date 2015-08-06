window.Pokedex = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    Pokedex.pokemonTypes = pokemonTypes;
    // var $el = $('#pokedex');
    // view = new Pokedex.Views.Pokemon({ el: $el });
    // view.refreshPokemon();
    new Pokedex.Routers.Router();
    Backbone.history.start();
  }
};

$(document).ready(function () {
  Pokedex.initialize();
});
