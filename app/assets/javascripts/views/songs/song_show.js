Notes.Views.SongShow = Backbone.View.extend({

  initialize: function(song) {
    var that = this;
    that.song = song; // TODO: determine if this should use a model instead
  },

  events: {
    // TODO: determine if it is safe to use JQuery's .on("select") and not this
    "mouseup .lyrics": "handleSelect",

  },

  render: function() {
    var that = this;

    var renderedContent = JST["songs/show"]( { song: that.song } );

    that.$el.html(renderedContent);

    return that;
  },

  handleSelect: function(event) {
    var that = this;
    // HTML breaks if we don't do this.
    if ($(".add-note").length > 0) {
      $(".add-note").remove();
      var htmlCopy = $(".lyrics").html();
      $(".lyrics").html(htmlCopy);
      return;
    }

    var sel = window.getSelection();

    // handle case of highlighting outside bounds of lyrics
    if (sel.anchorNode !== sel.focusNode) {
      return;
    }

    console.log("Selection!");

    var range = sel.getRangeAt(0);
    //var contents = range.cloneContents();

    var lowEnd = sel.extentOffset < sel.baseOffset ? sel.extentOffset : sel.baseOffset;
    var highEnd = sel.extentOffset < sel.baseOffset ? sel.baseOffset : sel.extentOffset;
    console.log(lowEnd);
    console.log(highEnd);

    var htmlCopy = $(".lyrics").html();
    htmlCopy = that.addButton(htmlCopy, highEnd);
    $(".lyrics").html(htmlCopy);
  },

  addButton: function(htmlCopy, highEnd) {
    var stringStart = htmlCopy.slice(0, highEnd);
    var stringEnd = htmlCopy.slice(highEnd);

    // Current image is a placeholder.
    var buttonHtml = "<span class='add-note'><img src='http://www.w3schools.com/images/compatible_safari.gif'></span>";

    return stringStart.concat(buttonHtml).concat(stringEnd);
  }
})