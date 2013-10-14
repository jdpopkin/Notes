# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

placeholder_user = User.create(email: "maboo@gmail.com", password: "password",
                            username: "Maboo")

placeholder_artist = Artist.create(name: "Nas", user_id: placeholder_user.id)

placeholder_album = Album.create(title: "Illmatic",
                  user_id: placeholder_user.id, artist_id: placeholder_artist.id)

long_lorem = Song.create(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
              lyrics: "Street's disciple, my raps are trifle\n
                        I shoot slugs from my brain just like a rifle\n
                        Stampede the stage, I leave the microphone split\n
                        Play Mr. Tuffy while I'm on some Pretty Tone shit\n
                        Verbal assassin, my architect pleases\n
                        When I was 12, I went to...\n
                        \n
                        [Hector]\n
                        And you're sitting at home doing this shit\n
                        I should be earning a medal for this\n
                        Stop fuckin' around and be a man, there ain't nothin' out here for you\n
                        \n
                        Zoro:\n
                        Oh yes there is...this\n
                        \n
                        [Jungle]\n
                        Yo, Nas, yo what the fuck is this bullshit on the radio son\n
                        \n
                        [Nas]\n
                        Chill chill, that's the shit God, chill\n
                        \n
                        [AZ]\n
                        Aiyyo yo, pull down the shade, man\n
                        Let's count this money, nigga\n
                        Ayeo Nas, put the Jacksons and the Grants over there\n
                        You know what I'm sayin'\n
                        Cause we spendin' the Jacksons\n
                        You know how we get down baby\n
                        \n
                        [Nas]\n
                        True, true\n
                        \n
                        [Jungle]\n
                        Nas, yo Nas, man shit is mad real right now in the projects\n
                        For a nigga yo, word to mother\n
                        All them crab-ass rappers\n
                        Be comin' up to me, man word to mother man\n
                        I think we need to let them niggas know it's real man\n
                        \n
                        [Nas]\n
                        True indeed, knamsayin', but when it's real you doin' this\n
                        Even without a record contract, knamsayin'\n
                        \n
                        [AZ]\n
                        No question\n
                        \n
                        [Nas]\n
                        Been doin this since back then\n
                        \n
                        [Jungle]\n
                        No doubt\n
                        \n
                        [AZ]\n
                        I'm sayin' regardless how it go down we gone keep it real\n
                        We tryin' to see many mansions and, and Coupes kid\n
                        \n
                        [Nas]\n
                        No doubt, we gon keep it real, true, true\n
                        \n
                        [Jungle]\n
                        Aiyyo where's Grand Wizard and Mayo at man\n
                        Takin' niggas a long time, man\n
                        \n
                        [Nas]\n
                        Who got the Phillies, take this Hennessy\n
                        \n
                        [AZ]\n
                        Aiyyo Dunn\n
                        C'mon, c'mon, man stop wavin' that man\n
                        Stop pointin' that at me Dunn, take the clip out\n
                        \n
                        [Nas]\n
                        Nigga alright but take this Hennessey man\n
                        \n
                        [AZ]\n
                        I'm sayin' take the clip man, c'mon, take it out\n
                        \n
                        [Nas]\n
                        Light them Phillies up man, niggas stop fuckin' burnin' Phillies man\n
                        Light some Phillies up then\n
                        \n
                        [Jungle]\n
                        Pass that henrock, pass that henrock, nigga, act like you know\n
                        \n
                        [AZ]\n
                        Yo, we drinkin' this straight up with no chaser\n
                        I ain't fuckin' with you nigga\n
                        \n
                        [Nas]\n
                        I'm saying though man\n
                        \n
                        [AZ]\n
                        What is it, what is it baby\n
                        \n
                        [Jungle]\n
                        What is it Son, what is it\n
                        \n
                        [AZ]\n
                        You know what time it is\n
                        \n
                        [Nas]\n
                        I'm saying man, ya know what I'm saying\n
                        Niggas don't listen man, representin' it's Illmatic\n
                        ",
      title: "The Genesis", user_id: placeholder_user.id)

# add notes, comments to long_lorem
start_index = long_lorem.lyrics.index("Street") + 7 # compensates for the 7 whitespaces at start of <p> tag in HTML
end_index = long_lorem.lyrics.index("I went to...") + "I went to...".length + 7

sunt_note = Note.create(author_id: placeholder_user.id,
            body: "Nas' verse from Main Source’s \“Live at the BBQ\”.
            This verse was his first appearance on record",
            start_index: start_index, end_index: end_index, song_id: long_lorem.id)

user_two = User.create(email: "sameoldshawn@yahoo.com", password: "password", username: "SameOldShawn")

long_lorem_comment = Comment.create(user_id: user_two.id, body: "This is not a song.",
                      commentable_id: long_lorem.id, commentable_type: "Song")

sunt_note_comment = Comment.create(user_id: user_two.id, body: "When did \"Live at the Barbecue\" come out?",
                      commentable_id: sunt_note.id, commentable_type: "Note")

sunt_note_comment_two = Comment.create(user_id: placeholder_user.id, body: "1991",
                      commentable_id: sunt_note.id, commentable_type: "Note")

# sunt_note_vote_1 = Vote.create(user_id: placeholder_user.id, value: 1,
#                                 votable_id: sunt_note.id, votable_type: "Note")

sunt_note_vote_2 = Vote.create(user_id: user_two.id,
                              value: 1,
                              votable_id: sunt_note.id,
                              votable_type: "Note")

long_lorem_comment_vote_1 = Vote.create(user_id: placeholder_user.id, value: -1,
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

