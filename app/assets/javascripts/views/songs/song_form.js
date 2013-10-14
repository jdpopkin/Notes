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
    event.preventDefault();
    var $target = $(event.currentTarget);
    var formData = $target.serializeJSON();


    $.ajax({
      url: formData.url,
      type: "POST",
      data: formData,
      success: function(data, textStatus, xhr) {
        // let the redirect go through?
        // success if 400. else render errors
        // console.log(data);
        that.$el.addClass("hidden");
        // redirect
        $(".success").html("Song created!");
        if (parseInt(data.id)) {
          location.href = Notes.rootUrl + "songs/" + parseInt(data.id);
        }
      },

      error: function(data) {
        // console.log("error");
        // console.log(data);
        for (var key in data.responseJSON) {
          if (key.toString() === "artist_id") {
            var errorString = "Error: you must select an artist";
          } else {
            var errorString = "Error: " + key.toString() + " " + data.responseJSON[key][0].toString();
          }
          $(".errors").html(errorString);
          console.log(errorString);
          break;
        }
      }
    })

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