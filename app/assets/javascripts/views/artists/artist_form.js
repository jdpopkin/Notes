Notes.Views.ArtistForm = Backbone.View.extend({
  initialize: function() {

  },

  events: {
    "submit form.artist-form": "submit"
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
      success: function(data) {
        that.$el.addClass("hidden");
        if (parseInt(data.id)) {
          location.href = Notes.rootUrl + "artists/" + parseInt(data.id);
        }
      },

      error: function(data) {
        for (var key in data.responseJSON) {
          var errorString = "Error: " + key.toString() + " " + data.responseJSON[key][0].toString();
          $(".errors").html(errorString);
          break;
        }
      }
    })
  },

  render: function() {
    var that = this;
    renderedContent = JST["artists/form"]( {
      url: Notes.rootUrl + "/artists/",
      method: "POST",
      authToken: Notes.authToken,
      currentUser: Notes.currentUser,
      artist: { name: "" }
    });

    if (Notes.currentUser) {
      that.$el.html(renderedContent);
    }

    return that;
  }
})