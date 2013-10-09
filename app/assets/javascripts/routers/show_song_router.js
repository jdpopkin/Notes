Notes.Routers.ShowSongRouter = Backbone.Router.extend({
  initialize: function($rootEl, song, notes, votes) {
    this.$rootEl = $rootEl;
    this.song = song;
    this.notes = notes;
    this.votes = votes;
  },

  routes: {
    // TODO: decide what goes here. Add Note, add comment?
    "": "show"

  },

  show: function() {
    // TODO: see what we get out of making song a model and passing it
    var that = this;
    var showSong = new Notes.Views.SongShow(that.song, that.notes);
    that.$rootEl.html(showSong.render().$el);
    // if ($(".lyrics")) {
//       console.log("In the if.");
//       $(document).click(that.handleSelect);
//     }
  }

  // handleSelect: function(event) {
//     console.log("Selection!");
//   }
})