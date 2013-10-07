Notes.Routers.AlbumsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    //"": "index",
    "albums/new": "new"
  },

  new: function() {
    // render new
    var that = this;

    var newView = new Notes.Views.AlbumForm();
    that.$rootEl.html(newView.render().$el);
  }
})