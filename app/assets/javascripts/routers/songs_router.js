Notes.Routers.SongsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    //"": "index",
    "songs/new": "new"
  },

  new: function() {
    // render new
    var that = this;

    var newView = new Notes.Views.SongForm();
    that.$rootEl.html(newView.render().$el);
  }
})