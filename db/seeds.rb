# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_one = User.create!(email: "maboo@gmail.com", password: "password",
                            username: "Maboo")

placeholder_artist = Artist.create!(name: "Nas", user_id: user_one.id)

placeholder_album = Album.create!(title: "Illmatic",
                  user_id: user_one.id, artist_id: placeholder_artist.id)

lyrics_string =
"Street's disciple, my raps are trifle
I shoot slugs from my brain just like a rifle
Stampede the stage, I leave the microphone split
Play Mr. Tuffy while I'm on some Pretty Tone shit
Verbal assassin, my architect pleases
When I was 12, I went to...

[Hector]
And you're sitting at home doing this shit
I should be earning a medal for this
Stop fuckin' around and be a man, there ain't nothin' out here for you

Zoro:
Oh yes there is...this

[Jungle]
Yo, Nas, yo what the fuck is this bullshit on the radio son

[Nas]
Chill chill, that's the shit God, chill

[AZ]
Aiyyo yo, pull down the shade, man
Let's count this money, nigga
Ayeo Nas, put the Jacksons and the Grants over there
You know what I'm sayin'
Cause we spendin' the Jacksons
You know how we get down baby

[Nas]
True, true

[Jungle]
Nas, yo Nas, man shit is mad real right now in the projects
For a nigga yo, word to mother
All them crab-ass rappers
Be comin' up to me, man word to mother man
I think we need to let them niggas know it's real man

[Nas]
True indeed, knamsayin', but when it's real you doin' this
Even without a record contract, knamsayin'

[AZ]
No question

[Nas]
Been doin this since back then

[Jungle]
No doubt

[AZ]
I'm sayin' regardless how it go down we gone keep it real
We tryin' to see many mansions and, and Coupes kid

[Nas]
No doubt, we gon keep it real, true, true

[Jungle]
Aiyyo where's Grand Wizard and Mayo at man
Takin' niggas a long time, man

[Nas]
Who got the Phillies, take this Hennessy

[AZ]
Aiyyo Dunn
C'mon, c'mon, man stop wavin' that man
Stop pointin' that at me Dunn, take the clip out

[Nas]
Nigga alright but take this Hennessey man

[AZ]
I'm sayin' take the clip man, c'mon, take it out

[Nas]
Light them Phillies up man, niggas stop fuckin' burnin' Phillies man
Light some Phillies up then

[Jungle]
Pass that henrock, pass that henrock, nigga, act like you know

[AZ]
Yo, we drinkin' this straight up with no chaser
I ain't fuckin' with you nigga

[Nas]
I'm saying though man

[AZ]
What is it, what is it baby

[Jungle]
What is it Son, what is it

[AZ]
You know what time it is

[Nas]
I'm saying man, ya know what I'm saying
Niggas don't listen man, representin' it's Illmatic"

long_lorem = Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
              lyrics: lyrics_string,
      title: "The Genesis", user_id: user_one.id)

# add note, comments to long_lorem
start_index = long_lorem.lyrics.index("Street") + 0 # compensates for the 0 whitespaces at start of <p> tag in HTML
end_index = long_lorem.lyrics.index("I went to...") + "I went to...".length + 0

sunt_note = Note.create(author_id: user_one.id,
            body: "Nas' verse from Main Source’s \“Live at the BBQ\”.
            This verse was his first appearance on record",
            start_index: start_index, end_index: end_index, song_id: long_lorem.id)

user_two = User.create(email: "sameoldshawn@yahoo.com", password: "password", username: "SameOldShawn")

long_lorem_comment = Comment.create(user_id: user_two.id, body: "This is not a song.",
                      commentable_id: long_lorem.id, commentable_type: "Song")

sunt_note_comment = Comment.create(user_id: user_two.id, body: "When did \"Live at the Barbecue\" come out?",
                      commentable_id: sunt_note.id, commentable_type: "Note")

sunt_note_comment_two = Comment.create(user_id: user_one.id, body: "1991",
                      commentable_id: sunt_note.id, commentable_type: "Note")

# sunt_note_vote_1 = Vote.create(user_id: user_one.id, value: 1,
#                                 votable_id: sunt_note.id, votable_type: "Note")

sunt_note_vote_2 = Vote.create(user_id: user_two.id,
                              value: 1,
                              votable_id: sunt_note.id,
                              votable_type: "Note")

long_lorem_comment_vote_1 = Vote.create(user_id: user_one.id, value: -1,
                                        votable_id: long_lorem_comment.id,
                                        votable_type: "Comment")


upvoters = []
15.times do |i|
  username = "upvoter_" + i.to_s
  email = username + "@upvotes.com"
  upvoter = User.create(email: email, password: "password", username: username)
  upvoters << upvoter
end

upvoters.each do |upvoter|
  Vote.create(user_id: upvoter.id, value: 1, votable_id: sunt_note.id, votable_type: "Note")
  Vote.create(user_id: upvoter.id, value: 1, votable_id: long_lorem.id, votable_type: "Song")
  Vote.create(user_id: upvoter.id, value: -1, votable_id: sunt_note_comment_two.id, votable_type: "Comment")
end



guest_user = User.create(email: "guest@herokuapp.com", password: "password",
                        username: "guest")

