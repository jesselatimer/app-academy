Journal.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: Journal.Models.Post,

  getOrFetch: function (id) {
    var post = this.get(id);
    if (!post) {
      post = new Journal.Models.Post({id: id});
      this.add(post);
    }
    post.fetch();
    return post;
  }

});
