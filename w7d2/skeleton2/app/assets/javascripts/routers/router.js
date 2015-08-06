Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "" : "pokemonIndex",
    "pokemon/:id" : "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail"
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $('#pokedex .pokemon-list').html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  pokemonDetail: function (pokeId, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(function () {
        this.pokemonDetail(pokeId, callback);
      }.bind(this));
      return;
    }
    var allPokemon = this._pokemonIndex.collection;

    var poke = allPokemon.find({ id: parseInt(pokeId) });
    this._pokemonDetail = new Pokedex.Views.PokemonDetail(poke);

    $('#pokedex .toy-detail').empty();
    $('#pokedex .pokemon-detail').html(this._pokemonDetail.$el);
    poke.fetch({
      success: callback
    });
  },

  toyDetail: function (pokeId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokeId, function () {
        this.toyDetail(pokeId, toyId);
      }.bind(this));
      return;
    }

    var toy = this._pokemonDetail.pokemon.toys().find({ id: parseInt(toyId) });
    var toyDetail = new Pokedex.Views.ToyDetail(toy);

    $('#pokedex .toy-detail').html(toyDetail.render().$el);
  },

  pokemonForm: function () {
    var newPoke = new Pokedex.Models.Pokemon();
    var collection = this._pokemonIndex.collection;
    var formView = new Pokedex.Views.PokemonForm(newPoke, collection);
    $('#pokedex .pokemon-form').html(formView.render().$el);
  }

});
