window.Notes = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Artists: [],
  Albums: [],
  toSigned: function(num) {
    if (num < 0) {
      return num.toString();
    } else {
      return "+" + num.toString();
    }
  },

  initialize: function(rootUrl) {
    Notes.rootUrl = rootUrl;
  }

};

$(document).ready(function(){
  //Notes.initialize(rootUrl);
});
