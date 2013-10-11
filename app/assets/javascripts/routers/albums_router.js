Notes.Routers.AlbumsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  // events: {
//     "click a.albums-new": "newButton"
//   },

  routes: {
    //"": "index",
    "albums/new": "new"
  },

  // newButton: function(event) {
//     var that = this;
//     console.log("Triggered");
//     event.preventDefault();
//     that.new();
//   },

  new: function() {
    // render new
    var that = this;

    var newView = new Notes.Views.AlbumForm();
    that.$rootEl.html(newView.render().$el);
  }
})