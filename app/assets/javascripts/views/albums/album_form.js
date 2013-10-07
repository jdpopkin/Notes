Notes.Views.AlbumForm = Backbone.View.extend({
  initialize: function() {

  },

  events: {
    "submit form.album-form": "submit"
  },

  submit: function(event) {
    // TODO: determine if this needs to do anything non-default
    var that = this;
    that.$el.addClass("hidden");
  },

  render: function() {
    var that = this;
    renderedContent = JST["albums/form"]( {
      url: Notes.rootUrl + "/albums/",
      method: "POST",
      artists: Notes.Artists,
      album: { title: "" }
    });

    that.$el.html(renderedContent);
    return that;
  }
})