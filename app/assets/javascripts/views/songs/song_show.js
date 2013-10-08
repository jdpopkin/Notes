Notes.Views.SongShow = Backbone.View.extend({

  initialize: function(song) {
    var that = this;
    that.song = song; // TODO: determine if this should use a model instead
  },

  events: {
    // TODO: determine if it is safe to use JQuery's .on("select") and not this
    "mouseup .lyrics": "handleSelect",
    "mousedown .lyrics": "startSelect"
  },

  render: function() {
    var that = this;

    var renderedContent = JST["songs/show"]( { song: that.song } );

    that.$el.html(renderedContent);

    return that;
  },

  startSelect: function(event) {
    var that = this;

    that.initialX = event.pageX;
    that.initialY = event.pageY;
  },

  handleSelect: function(event) {
    var that = this;
    // HTML breaks if we don't do this.
    if ($(".add-note").length > 0) {
      $(".add-note").remove();

      // removeClass("highlighted");
      $(".highlighted").replaceWith($(".highlighted").html());
      // $(".lyrics").html(html.replace("<span class='highlighted>", ""));
      // $(".lyrics").html(html.replace("</span>", ""));

      var htmlCopy = $(".lyrics").html();
      $(".lyrics").html(htmlCopy);
      return;
    }

    console.log(event);

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

    // Add button to the right of selection
    // htmlCopy = that.addButton(htmlCopy, highEnd);

    // Add button and highlighted span from start of selection to end of
    // selection
    htmlCopy = that.addHighlight(htmlCopy, lowEnd, highEnd);

    $(".lyrics").html(htmlCopy);
  },

  addHighlight: function(htmlCopy, lowEnd, highEnd) {
    var buttonHtml = "<span class='add-note'><img src='http://www.w3schools.com/images/compatible_safari.gif'></span>";
    var stringStart = htmlCopy.slice(0, lowEnd).concat("<span class='highlighted'>");
    var stringMiddle = htmlCopy.slice(lowEnd, highEnd).concat("</span>").concat(buttonHtml);
    var stringEnd = htmlCopy.slice(highEnd);

    return stringStart.concat(stringMiddle).concat(stringEnd);
  },

  addButton: function(htmlCopy, highEnd) {
    var stringStart = htmlCopy.slice(0, highEnd);
    var stringEnd = htmlCopy.slice(highEnd);

    // Current image is a placeholder.
    var buttonHtml = "<span class='add-note'><img src='http://www.w3schools.com/images/compatible_safari.gif'></span>";

    return stringStart.concat(buttonHtml).concat(stringEnd);
  }
})