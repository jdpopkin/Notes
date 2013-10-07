Notes.Views.SongForm = Backbone.View.extend({
  initialize: function() {

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
    renderedContent = JST["songs/form"]( {
      url: Notes.rootUrl + "/songs/",
      method: "POST",
      artists: Notes.Artists,
      albums: Notes.Albums,
      song: { lyrics: "" }
    });

    that.$el.html(renderedContent);
    return that;
  }
})