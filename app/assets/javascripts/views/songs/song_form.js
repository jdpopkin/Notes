Notes.Views.SongForm = Backbone.View.extend({
  initialize: function(albums, artists) {
    this.albums = albums;
    this.artists = artists;
  },

  events: {
    "submit form.song-form": "submit"
  },

  submit: function(event) {
    // TODO: determine if this needs to do anything non-default
    var that = this;
    that.$el.addClass("hidden");
  },

  render: function() {
    var that = this;
    console.log(Notes.currentUser);
    renderedContent = JST["songs/form"]( {
      url: Notes.rootUrl + "/songs/",
      method: "POST",
      artists: Notes.Artists,
      albums: Notes.Albums,
      authToken: Notes.authToken,
      currentUser: Notes.currentUser,
      song: { lyrics: "" }
    });



    if (Notes.currentUser) {
      that.$el.html(renderedContent);
    }

    return that;
  }
})