Notes.Views.SongShow = Backbone.View.extend({

  initialize: function(song, notes) {
    var that = this;
    that.song = song; // TODO: determine if this should use a model instead
    that.notes = notes;
    that.keepBox = false;
  },

  events: {
    // TODO: determine if it is safe to use JQuery's .on("select") and not this
    "mouseup .add-note": "keepSelect",
    "mouseup #lyrics": "handleSelect",
    "mousedown #lyrics": "startSelect",
    "submit .add-note-form": "createNote",
    "submit .note-comment-form": "createNoteComment",
    "click #lyrics>a": "displayNote",
    "click #lyrics": "hideNotes"
  },

  displayNote: function(event) {
    event.preventDefault();
    event.stopPropagation();
    this.hideNotes(event);
    // create a div
    // populate it with contents of the note with the data-id assoc with the event
    // toggle it to not hidden. should we bootstrap them as hidden on page load?
    $target = $(event.target);
    var dataId = $target.attr("data-id");
    var pos = $target.offset();
    var $note = $("div" + "[data-id='" + dataId + "']");
    console.log($note);
    $note.css("top", pos.top.toString() + "px");
    $note.removeClass("hidden");
  },

  hideNotes: function(event) {
    $(".note").addClass("hidden");
  },

  render: function() {
    var that = this;
    console.log(that.notes);
    console.log(that.song);

    var renderedContent = JST["songs/show"]({
       song: that.song,
       notes: that.notes,
       currentUser: Notes.currentUser
    });
    renderedContent = that.addNotes(renderedContent);

    that.$el.html(renderedContent);

    return that;
  },

  addNotes: function(renderedContent) {
    var pStart = renderedContent.indexOf('<p id="lyrics">') + '<p id="lyrics">'.length;
    this.pStart = pStart;
    console.log(this.notes)
    for (var i = 0; i < this.notes.length; i++) {
      var note = this.notes[i];
      var substringEnd = pStart + note.end_index;
      var substringStart = pStart + note.start_index;

      var contentEnd = renderedContent.slice(substringEnd);
      var contentMiddle = renderedContent.slice(substringStart, substringEnd);
      var contentStart = renderedContent.slice(0, substringStart);

      contentMiddle = "<a href='#' data-id=" + note.id + ">" + contentMiddle + "</a>";
      console.log(contentMiddle);
      renderedContent = contentStart + contentMiddle + contentEnd;
    }
    return renderedContent;
  },

  createNote: function(event) {
    var that = this;
    event.preventDefault();

    var formData = $(event.currentTarget).serializeJSON();

    $.ajax({
      url: "/notes",
      type: "POST",
      data: formData,
      success: function() {
        console.log("success");
        //that.render();
      }
    });

    //that.render();
  },

  createNoteComment: function(event) {
    var that = this;
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();

    $.ajax({
      url: "/comments",
      type: "POST",
      data: formData,
      success: function() {
        // do nothing?
      }
    });
  },

  keepSelect: function(event) {
    this.keepBox = true;
    return;
  },

  startSelect: function(event) {
    var that = this;

    that.initialX = event.pageX;
    that.initialY = event.pageY;
  },

  handleSelect: function(event) {
    var that = this;
    var sel = window.getSelection();
    console.log(sel);

    if (that.keepBox) {
      that.keepBox = false;
      return;
    }

    // HTML breaks if we don't do this.
    if ($(".add-note").length > 0) {
      $(".add-note").remove();
      // removeClass("highlighted");
      $(".highlighted").replaceWith($(".highlighted").html());

      var htmlCopy = $("#lyrics").html();
      $("#lyrics").html(htmlCopy);
      return;
    }

    // handle case of highlighting outside bounds of lyrics
    if (sel.anchorNode !== sel.focusNode) {
      return;
    }

    // do nothing if no range of text is highlighted.
    // without this, every click creates a form.
    if (sel.type !== "Range") {
      return;
    }

    var range = sel.getRangeAt(0);

    var lowEnd = sel.focusOffset < sel.anchorOffset ? sel.focusOffset : sel.anchorOffset;
    var highEnd = sel.focusOffset < sel.anchorOffset ? sel.anchorOffset : sel.focusOffset;
    console.log(lowEnd);
    console.log(highEnd);

    var htmlCopy = $("#lyrics").html();

    // Add button and highlighted span from start of selection to end of
    // selection
    var startIndex = this.selStartIndex(sel) + lowEnd;
    var endIndex = startIndex + (highEnd - lowEnd);

    htmlCopy = that.addHighlight(htmlCopy, startIndex, endIndex);

    $("#lyrics").html(htmlCopy);
  },

  // Index within HTML of p element. Used for finding selection to highlight.
  selStartIndex: function(sel) {
    var node = sel.anchorNode.previousSibling;
    var sum = 0;
    var bigString = "";

    while (node) {
      var container = document.createElement("div");
      container.appendChild(node.cloneNode());
      bigString += container.innerHTML;
      sum += container.innerHTML.length;

      node = node.previousSibling;
      if (node === undefined) {
        break;
      }
    }

    console.log(bigString);

    return sum;
  },

  // Finds text (NOT HTML) within p (prior to lowEnd) and returns length of this text.
  findStartIndex: function(lowEnd) {
    var $p = $("#lyrics");
    var $div = $("<div></div>");
    var p = $p.html();

    var slicedP = p.slice(0, lowEnd);
    $div.append(slicedP);

    console.log($div.text());
    //console.log($div.text().length);
    return $div.text().length;
  },

  addHighlight: function(htmlCopy, lowEnd, highEnd) {
    // Image to test if the add-note div is broken.
    // <img src='http://www.w3schools.com/images/compatible_safari.gif'>
    var startIndex = this.findStartIndex(lowEnd);

    var formString = JST["notes/form"]({
      songId: this.song.id,
      currentUser: Notes.currentUser,
      authToken: Notes.authToken,
      lowEnd: startIndex, // lowEnd,
      highEnd: startIndex + (highEnd - lowEnd) // highEnd
    });

    var buttonHtml = "<div class='add-note'>".concat(formString).concat("</div>");
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
});