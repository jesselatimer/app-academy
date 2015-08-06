Pokedex.Views.PokemonForm = Backbone.View.extend({
  template: JST["pokemonForm"],

  events: {
    "submit form" : "savePokemon"
  },

  initialize: function (pokemon, collection) {
    this.pokemon = pokemon;
    this.collection = collection;
  },

  render: function () {
    var renderedContent = this.template({ pokemon: this.pokemon });
    this.$el.html(renderedContent);
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    this.pokemon.save(attributes.pokemon, {
      success: function () {
        this.collection.add(this.pokemon);
        Backbone.history.navigate("/pokemon/" + this.pokemon.id,
                                  { trigger: true });
        this.pokemon = new Pokedex.Models.Pokemon();
        this.render();
      }.bind(this)
    });
  }
});
