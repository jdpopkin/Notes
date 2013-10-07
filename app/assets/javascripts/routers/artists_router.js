Notes.Routers.ArtistsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    //"": "index",
    "artists/new": "new"
  },

  new: function() {
    // render new
    var that = this;

    var newView = new Notes.Views.ArtistForm();
    that.$rootEl.html(newView.render().$el);
  }
})