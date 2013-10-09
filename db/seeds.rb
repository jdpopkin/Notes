# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

placeholder_user = User.create(email: "asdf@asdf.com", password: "password", username: "username")
placeholder_artist = Artist.create(name: "Placeholder Artist", user_id: placeholder_user.id)
placeholder_album = Album.create(title: "Placeholder: The Album", user_id: placeholder_user.id, artist_id: placeholder_artist.id)
long_lorem = Song.create(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
              lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              title: "Long Lorem", user_id: placeholder_user.id)

# add notes, comments to long_lorem
start_index = long_lorem.lyrics.index("sunt") + 7 # compensates for 7 whitespaces at start of <p> tag in HTML
end_index = start_index + "sunt".length

sunt_note = Note.create(author_id: placeholder_user.id, body: 'Sunt means "are."',
              start_index: start_index, end_index: end_index, song_id: long_lorem.id)

long_lorem_comment = Comment.create(user_id: placeholder_user.id, body: "This is not a song.",
                      commentable_id: long_lorem.id, commentable_type: "Song")

sunt_note_comment = Comment.create(user_id: placeholder_user.id, body: "That's awesome!",
                      commentable_id: sunt_note.id, commentable_type: "Note")