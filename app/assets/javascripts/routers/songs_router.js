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
    // add the on-change handler to artist-select

    $(".artist-select").change(function() {
      console.log("Select triggered");
      var artistId = $("select option:selected").attr("value");
      var htmlString = "";
      _.each(Notes.Albums, function(album) {
        if (album.artist_id == artistId) {
          htmlString += '<option class="album-option" value="' + album.id + '">' + album.title + '</option>';
        }
      })
      $(".album-select").html(htmlString);
    })
  }
})