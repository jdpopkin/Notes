Notes.Views.AlbumForm = Backbone.View.extend({
  initialize: function() {

  },

  events: {
    "submit form.album-form": "submit"
  },

  submit: function(event) {
    // TODO: determine if this needs to do anything non-default
    var that = this;
    event.preventDefault();
    var $target = $(event.currentTarget);
    var formData = $target.serializeJSON();

    $.ajax({
      url: Notes.rootUrl + "albums",
      type: "POST",
      data: formData,
      success: function(data) {
        that.$el.addClass("hidden");
        $(".success").html("Album created!")
        if (parseInt(data.id)) {
          location.href = Notes.rootUrl + "albums/" + parseInt(data.id);
        }
      },

      error: function(data) {
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
    renderedContent = JST["albums/form"]( {
      url: Notes.rootUrl + "/albums/",
      method: "POST",
      artists: Notes.Artists,
      authToken: Notes.authToken,
      currentUser: Notes.currentUser,
      album: { title: "" }
    });

    if (Notes.currentUser) {
      that.$el.html(renderedContent);
    }

    return that;
  }
})