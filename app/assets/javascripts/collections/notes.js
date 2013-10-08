Notes.Collections.Notes = Backbone.Collection.extend({
  model: Notes.Models.Note,
  url: "/notes"
});