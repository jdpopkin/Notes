Notes.Views.SongShow = Backbone.View.extend({

  initialize: function(song) {
    var that = this;
    that.song = song; // TODO: determine if this should use a model instead
  },

  events: {
    // TODO: determine if it is safe to use JQuery's .on("select") and not this
    "mouseup .lyrics": "handleSelect"
  },

  render: function() {
    var that = this;

    var renderedContent = JST["songs/show"]( { song: that.song } );

    that.$el.html(renderedContent);

    return that;
  },

  handleSelect: function(event) {
    console.log("Selection!");
    var sel = window.getSelection();
    var range = sel.getRangeAt(0);
    var contents = range.cloneContents();

    // console.log("Sel: " + sel);
    //     console.log("Range: " + range);
    //     console.log("Contents: " + contents);
    console.log(sel);
    console.log(range);
    console.log(contents);
    console.log(sel.toString());
  }
})