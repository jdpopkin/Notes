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

user_two = User.create(email: "sameoldshawn@yahoo.com", password: "password", username: "SameOldShawn")

additional_user = User.create!(email: "paulr@gmail.com", password: "password", username: "prettysmacked")
additional_user = User.create!(email: "epree@gmail.com", password: "password", username: "spacekingdom")
additional_user = User.create!(email: "alanm@gmail.com", password: "password", username: "Sinonim")
additional_user = User.create!(email: "elsmith@gmail.com", password: "password", username: "gleeGear")
additional_user = User.create!(email: "abr88@gmail.com", password: "password", username: "LiquidSwordz")
additional_user = User.create!(email: "bantam@gmail.com", password: "password", username: "saltdog")
additional_user = User.create!(email: "ponies@gmail.com", password: "password", username: "Short")

placeholder_artist = Artist.create!(name: "Nas", user_id: user_one.id)

additional_id = User.where(username: "LiquidSwordz").first.id
camron = Artist.create!(name: "Cam'ron", user_id: additional_id)
cano = Artist.create!(name: "Cannibal Ox", user_id: user_one.id)
gza = Artist.create!(name: "GZA", user_id: additional_id)
mf = Artist.create!(name: "MF DOOM", user_id: user_one.id)

placeholder_album = Album.create!(title: "Illmatic",
                  user_id: user_one.id, artist_id: placeholder_artist.id)

purple_haze = Album.create!(title: "Purple Haze",
                  user_id: user_one.id, artist_id: camron.id)

gh = Album.create!(title: "Ghetto Heaven Volume 1", user_id: user_one.id,
artist_id: camron.id)

liquid_swords = Album.create!(title: "Liquid Swords", user_id: additional_id,
artist_id: gza.id)

cold_vein = Album.create!(title: "The Cold Vein", user_id: user_two.id,
artist_id: cano.id)

operation_doomsday = Album.create!(title: "Operation: Doomsday",
user_id: user_two.id, artist_id: mf.id)

mm_food = Album.create!(title: "Mm... Food?", user_id: user_two.id,
artist_id: mf.id)

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

lyrics_string =
"[Intro]
Straight out the fucking dungeons of rap
Where fake niggas don't make it back
I don't know how to start this shit, yo

[Verse 1]
Rappers, I monkey flip em with the funky rhythm
I be kicking, musician, inflictin' composition
Of pain I'm like Scarface sniffin cocaine
Holding an M-16, see with the pen I'm extreme, now
Bullet holes left in my peepholes, I'm suited up in street clothes
Hand me a nine and I'll defeat foes
Y'all know my steelo with or without the airplay
I keep some E&J, sitting bent up in the stairway
Or either on the corner betting Grants with the cee-lo champs
Laughing at baseheads trying to sell some broken amps
G-packs get off quick, forever niggas talk shit
Reminiscing about the last time the Task Force flipped
Niggas be running through the block shootin'
Time to start the revolution, catch a body, head for Houston
Once they caught us off-guard, the Mac-10 was in the grass and
I ran like a cheetah with thoughts of an assassin
Pick the Mac up, told brothers, \"Back up,\" the Mac spit
Lead was hitting niggas, one ran, I made him backflip
Heard a few chicks scream, my arm shook, couldn't look
Gave another squeeze, heard it click, \"yo, my shit is stuck\"
Try to cock it, it wouldn't shoot, now I'm in danger
Finally pulled it back and saw 3 bullets caught up in the chamber
So now I'm jetting to the building lobby
And it was filled with children probably couldn't see as high as I be
(So what you saying?) It's like the game ain't the same
Got younger niggas pulling the triggers, bringing fame to their name
And claim some corners, crews without guns are goners
In broad daylight, stickup kids: they run up on us
45's and gauges, Macs, in fact
Same niggas will catch a back-to-back, snatching your cracks in black
There was a snitch on the block getting niggas knocked
So hold your stash 'til the coke price drop
I know this crackhead who said she's got to smoke nice rock
And if it's good, she'll bring you customers in measuring pots
But yo, you gotta slide on a vacation, inside information
Keeps large niggas erasin' and their wives basin'
It drops deep as it does in my breath
I never sleep, cause sleep is the cousin of death
Beyond the walls of intelligence, life is defined
I think of crime when I'm in a New York state of mind

[Hook]
New York state of mind

[Verse 2]
Be having dreams that I'm a gangsta; drinking Moets, holding Tecs
Making sure the cash came correct, then I stepped
Investments in stocks, sewing up the blocks to sell rocks
Winning gunfights with mega-cops
But just a nigga walking with his finger on the trigger
Make enough figures until my pockets get bigger
I ain't the type of brother made for you to start testin'
Give me a Smith and Wesson, I have niggas undressin'
Thinking of cash flow, buddah and shelter
Whenever frustrated, I'm a hijacked Delta
In the P.J.'s, my blend tape plays, bullets are strays
Young bitches is grazed, each block is like a maze
Full of black rats trapped, plus the Island is packed
From what I hear in all the stories when my peoples come back, black
I'm living where the nights is jet-black
The fiends fight to get crack I just max, I dream I can sit back
And lamp like Capone, with drug scripts sewn
Or the legal luxury life, rings flooded with stones, homes
I got so many rhymes I don't think I'm too sane
Life is parallel to Hell but I must maintain
And be prosperous, though we live dangerous, cops could just
Arrest me, blaming us, we're held like hostages
It's only right that I was born to use mics
And the stuff that I write is even tougher than dykes
I'm taking rappers to a new plateau, through rap slow
My rhymin' is a vitamin held without a capsule
The smooth criminal on beat breaks
Never put me in your box if your shit eats tapes
The city never sleeps, full of villains and creeps
That's where I learned to do my hustle had to scuffle with freaks
I'm an addict for sneakers, 20's of buddah and bitches with beepers
In the streets I can greet ya, about blunts I teach ya
Inhale deep like the words of my breath
I never sleep, cause sleep is the cousin of death
I lay puzzle as I backtrack to earlier times
Nothing's equivalent to the New York state of mind

[Hook]"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "N.Y. State of Mind", user_id: user_one.id)

lyrics_string =
"[Intro]
Ayo what's up what's up let's keep it real son (AZ)
Count this money, you know what I'm saying?
Yeah yeah (Nas)
Ayo put the Grants over there in the safe you know what I'm sayin'
Cause we spendin' these Jacksons
The Washingtons go to wifey, you know how that go
I'm saying, that's what this is all about right?
Clothes, bankrolls, and hoes you know what I'm saying?
Yo then what man, what? (Nas)

[Verse 1: AZ]
Visualizing the realism of life and actuality
Fuck who's the baddest, a person's status depends on salary
And my mentality is money-orientated
I'm destined to live the dream for all my peeps who never made it
Cause yeah, we were beginners in the hood as 5 percenters
But something must of got in us cause all of us turned to sinners
Now some resting in peace and some are sitting in San Quentin
Others such as myself are trying to carry on tradition
Keeping that effervescent street ghetto essence inside us
Cause it provides us with the proper insight to guide us
Even though, we know somehow we all gotta go
But as long as we leaving thieving, we'll be leaving with some kind of dough
So, until that day we expire and turn to vapors
Me and my capers will be somewhere else stacking plenty papers
Keeping it real, packing steel, getting high
Cause life's a bitch and then you die

[Hook: AZ]
Life's a bitch and then you die
That's why we get high
Cause you never know when you're gonna go
Life's a bitch and then you die
That's why we puff lye
Cause you never know when you're gonna go

[Verse 2: Nas]
I woke up early on my born day, I'm 20, it's a blessing
The essence of adolescence leaves my body, now I'm fresh and
My physical frame is celebrated cause I made it
One quarter through life some Godly-like thing created
Got rhymes 365 days annual plus some
Load up the mic and bust one, cuss while I puffs from
My skull cause it's pain in my brain vein, money maintain
Don't go against the grain, simple and plain
When I was young, at this I used to do my thing hard
Robbing foreigners, take their wallets, their jewels, and rip their green cards
Dipped to the projects flashing my quick cash and
Got my first piece of ass smoking blunts with hash
Now it's all about cash in abundance
Niggas I used to run with is rich or doing years in the hundreds
I switched my motto; instead of saying \"fuck tomorrow\"
That buck that bought a bottle could've struck the lotto
Once I stood on the block, loose cracks produce stacks
I cooked up and cut small pieces to get my loot back
Time is Illmatic, keep static like wool fabric
Pack a 4-matic that crack your whole cabbage

[Hook]"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "Life's a Bitch", user_id: user_one.id)

lyrics_string =
"[Hook: Pete Rock]
Whose world is this?
(The world is yours, the world is yours)
It's mine, it's mine, it's mine

[Verse 1]
I sip the Dom P, watching \"Gandhi\" 'til I'm charged
Then writing in my book of rhymes, all the words past the margin
To hold the mic I'm throbbing, mechanical movement
Understandable smooth shit that murderers move with
The thief's theme - play me at night, they won't act right
The fiend of hip-hop has got me stuck like a crack pipe
The mind activation, react like I'm facing time like
\"Pappy\" Mason, with pens I'm embracing
Wipe the sweat off my dome, spit the phlegm on the streets
Suede Timbs on my feets makes my cipher complete
Whether cruising in a Sikh's cab or Montero Jeep
I can't call it, the beats make me falling asleep
I keep falling, but never falling six feet deep
I'm out for presidents to represent me (Say what?)
I'm out for presidents to represent me (Say what?)
I'm out for dead presidents to represent me

[Hook]

[Verse 2]
To my man Ill Will, God bless your life
To my peoples throughout Queens, God bless your life
I trip, we box up crazy bitches, aiming guns in all my baby pictures
Beef with housing police, release scriptures that's maybe Hitler's
Yet I'm the mild, money-getting style, rolling foul
The versatile, honey-sticking wild golden child
Dwelling in the Rotten Apple, you get tackled
Or caught by the devil's lasso, shit is a hassle
There's no days, for broke days we sell it: smoke pays
While all the old folks pray to Jesús, soaking their sins in trays
Of holy water, odds against Nas are slaughter
Thinking a word best describing my life to name my daughter
My strength, my son, the star, will be my resurrection
Born in correction, all the wrong shit I did, he'll lead a right direction
\"How you living?\" Large, a broker charge - cards are mediocre
You flipping coke or playing spit spades and strip poker?

[Hook]

[Verse 3]
I'm the young city bandit, hold myself down single-handed
For murder raps, I kick my thoughts alone, get remanded
Born alone, die alone, no crew to keep my crown or throne
I'm deep by sound alone, caved inside, 1,000 miles from home
I need a new nigga for this black cloud to follow
Cause while it's over me it's too dark to see tomorrow
Trying to maintain, I flip, fill the clip to the tip
Picturing my peeps not eating can make my heartbeat skip
And I'm amped up, they locked the champ up, even my brain's in handcuffs
Headed for Indiana, stabbing women like the Phantom
The crew is lamping, Big Willie style
Check the chip-toothed smile, plus I profile wild
Stash loot in fly clothes, burning dollars to light my stove
Walk the blocks with a bop, checking dames
Plus the games people play, bust the problems of the world today

[Hook]"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "The World is Yours", user_id: user_one.id)

lyrics_string =
"[Intro]
Check me out y'all
Nasty Nas in your area
About to cause mass hysteria

[Verse 1]
Before I blunt, I take out my fronts
Then I start to front; matter of fact, I be on a manhunt
You couldn't catch me in the streets without a ton of reefer
That's like Malcolm X catching the Jungle Fever
King poetic. Too much flavor, I'm major
Atlanta ain't Brave-r, I'll pull a number like a pager
Cause I'm an ace when I face the bass
40-side is the place that is giving me grace
Now wait, another dose and you might be dead
And I'm a Nike-head, I wear chains that excite the Feds
And ain't a damn thing gonna change
I'mma performer strange, so the mic warmer was born to gain
Nas, why did you do it
You know you got the mad fat fluid when you rhyme, it's halftime

[Hook]
It's halftime
This is how it feel, check it out, how it feel

[Verse 2]
It's like that, you know it's like that
I got it hemmed, now you never get the mic back
When I attack, there ain't an army that could strike back
So I react never calmly on a hype track
I set it off with my own rhyme
Cause I'm as ill as a convict who kills for phone time
I'm max like cassettes, I flex like sex
In your stereo sets, Nas'll catch wreck
I used to hustle - now all I do is relax and strive
When I was young I was a fan of the Jackson 5
I drop jewels, wear jewels, hope to never run it
With more kicks than a baby in a mother's stomach
Nasty Nas has to rise cause I'm wise
This is exercise 'til the microphone dies
Back in '83 I was an MC sparkin'
But I was too scared to grab the mics in the parks and
Kick my little raps cause I thought nigga wouldn't understand
And now in every jam I'm the fuckin' man
I rap in front of more niggas than in the slave ships
I used to watch \"CHiPs\", now I load Glock clips
I got to have it, I miss Mr. Magic
Versatile, my style switches like a faggot
But not bisexual, I'm an intellectual
Of rap I'm a professional and that's no question, yo
These are the lyrics of the man, you can't near it, understand?
Cause in the streets, I'm well-known like the number man
Am I in place with the bass and format
Explore rap and tell me \"Nas ain't all that\"
And next time I rhyme, I be foul
Whenever I freestyle I see trial, niggas say I'm wild
I hate a rhyme-biter's rhyme
Stay tuned, Nas soon - the real rap comes at halftime

[Hook]

[Verse 3]
I got it going on, even flip em on this song
Every afternoon, I kick half the tune
And in the darkness, I'm heartless like when the NARC's hit
Word to Marcus Garvey: I hardly sparked it
Cause when I blast the herb, that's my word
I be slayin' them fast, doing this that and the third
But chill, pass the Andre, and let's slay
I bag bitches up at John Jay, and hit a matinee
Putting hits on 5-0
Cause when it's my time to go, I wait for God with the .44
And biters can't come near
And yo: \"go to hell\" to the foul cop who shot Garcia
I won't plant seeds, don't need an extra mouth I can't feed
That's extra Phillie change, more cash for damp weed
This goes out to Manhattan, the island of Staten
Brooklyn and Queens is living fat and
The Boogie Down, enough props, enough clout
Ill Will, rest in peace, yo, I'm out"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "Halftime", user_id: user_one.id)

lyrics_string =
"[Verse 1]
I rap for listeners, bluntheads, fly ladies and prisoners
Henessey-holders and old-school niggas
Then I be dissing a Unofficial that smoke Woolie Thai
I dropped out of Cooley High, gassed up by a cokehead cutie pie
Jungle survivor, fuck who's the live-er
My man put the battery in my back, a difference from Energizer
Sentence begins indented with formality
My duration's infinite, moneywise or physiology
Poetry, that's a part of me, retardedly bop
I drop the ancient manifested hip-hop straight off the block
I reminisce on park jams, my man was shot for his sheep coat
Childhood lesson make me see him drop in my weed smoke
It's real, grew up in trife life, the times of white lines
The hype vice, murderous nighttimes and knife fights invite crimes
Chill on the block with Cognac, hold strap
With my peeps that's into drug money, market into rap
No sign of the beast in the blue Chrysler, I guess that means peace
For niggas no sheisty vice to just snipe ya
Start off the dice-rolling mats for craps to cee-lo
With side-bets, I roll a deuce, nothing below (Peace God!)
Peace God -- now the shit is explained
I'm taking niggas on a trip straight through memory lane
It's like that y'all

[Hook]
\"Now let me take a trip down memory lane\"
\"Coming outta Queensbridge\"

[Verse 2]
One for the money
Two for pussy and foreign cars
Three for Alize, niggas deceased or behind bars
I rap divine, God, check the prognosis: is it real or showbiz?
My window faces shootouts, drug overdoses
Live amongst no roses, only the drama, for real
A nickel-plate is my fate, my medicine is the ganja
Here's my basis, my razor embraces, many faces
Your telephone blowing, black stitches or fat shoelaces
Peoples are petro, dramatic automatic .44 I let blow
And back down po-po when I'm vexed so
My pen taps the paper then my brain's blank
I see dark streets, hustling brothers who keep the same rank
Pumping for something, some'll prosper, plus some fail
Judges hanging niggas, uncorrect bails for direct sales
My intellect prevails from a hanging cross with nails
I reinforce the frail, with lyrics that's real
Word to Christ, a disciple of streets, trifle on beats
I decipher prophecies through a mic and say peace
I hung around the older crews while they sling smack to dingbats
They spoke of Fat Cat, that nigga's name made bell rings, black
Some fiends scream, about Supreme Team, a Jamaica Queens thing
Uptown was Alpo, son, heard he was kingpin, yo
Fuck \"rap is real\", watch the herbs stand still
Never talking to snakes cause the words of man kill
True in the game, as long as blood is blue in my veins
I pour my Heineken brew to my deceased crew on memory lane"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "Memory Lane", user_id: user_one.id)

lyrics_string =
"[Verse 1]
What up kid? I know shit is rough doing your bid
When the cops came you should have slid to my crib
Fuck it black, no time for looking back it's done
Plus congratulations, you know you got a son
I heard he looks like ya, why don't your lady write ya?
Told her she should visit, that's when she got hyper
Flipping, talking 'bout he acts too rough
He didn't listen he be riffing while I'm telling him stuff
I was like yeah, shorty don't care, she a snake too
Fucking with them niggas from that fake crew that hate you
But yo, guess who got shot in the dome-piece?
Jerome's niece, on her way home from Jones Beach
It's bugged, plus little Rob is selling drugs on the dime
Hanging out with young thugs that all carry nines
And night time is more trife than ever
What up with Cormega, did you see him, are y'all together?
If so then hold the fort down, represent to the fullest
Say what's up to Herb, Ice and Bullet
I left a half a hundred in your commissary
You was my nigga when push came to shove, one what? (One love)

[Verse 2]
Dear Born, you'll be out soon, stay strong
Out in New York the same shit is going on
The crackheads stalking, loudmouths is talking
Hold, check out the story yesterday when I was walking
That nigga you shot last year tried to appear
Like he hurting something, word to mother, I heard him fronting
And he be pumping on your block, your man gave him your Glock
And now they run together, what up son, whatever
Since I'm on the streets I'mma put it to a cease
But I heard you blew a nigga with a ox for the phone piece
Wilding on the Island, but now in Elmira
Better chill cause them niggas will put that ass on fire
Last time you wrote you said they tried you in the showers
But maintain when you come home the corner's ours
On the reals, all these crab niggas know the deal
When we start the revolution all they probably do is squeal
But chill, see you on the next V-I
I gave your ma duke's loot for kicks, plus sent you flicks
Your brother's buckwilding in 4-Main, he wrote me
He might beat his case, 'til he come home, play it low key
So stay civilized, time flies
Though incarcerated your mind die, I hate it when your moms cries
It kinda makes me want to murder, for reala
I even got a mask and gloves to bust slugs but one love

[Verse 3]
Sometimes I sit back with a Buddha sack
Mind's in another world thinking how can we exist through the facts
Written in school text books, bibles, et cetera
Fuck a school lecture, the lies get me vexed-er
So I be ghost from my projects, I take my pen and pad
For the weekend hittin L's while I'm sleeping
A two day stay, you may say I need the time alone
To relax my dome, no phone, left the nine at home
You see the streets had me stressed something terrible
Fucking with the corners have a nigga up in Bellevue
Or HDM, hit with numbers from 8 to 10
A future in a maximum state pen is grim
So I comes back home, nobody's out but Shorty Doo-Wop
Rolling two phillies together in the Bridge we called 'em oo-wops
He said \"Nas, niggas cold be busting off the roof
So I wear a bullet proof and pack a black trey-deuce\"
He inhaled so deep, shut his eyes like he was sleep
Started coughing, one eye peeked to watch me speak
I sat back like The Mack, my army suit was black
We was chilling on these benches where he pumped his loose cracks
I took the L when he passed it, this little bastard
Keeps me blasted and starts talking mad shit
I had to school him, told him don't let niggas fool him
Cause when the pistol blows the one that's murdered be the cool one
Tough luck when niggas are struck, families fucked up
Coulda caught your man, but didn't look when you bucked up
Mistakes happen, so take heed never bust up
At the crowd catch him solo, make the right man bleed
Shorty's laugh was cold blooded as he spoke so foul
Only twelve trying to tell me that he liked my style
Then I rose, wiping the blunt's ash from my clothes
Then froze only to blow the herb smoke through my nose
And told my little man I'mma ghost [???]
Left some jewels in his skull that he can sell if he chose
Words of wisdom from Nas: try to rise up above
Keep an eye out for Jake, Shorty Wop, one love"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "One Love", user_id: user_one.id)

lyrics_string =
"[Produced by Large Professor]

[Intro - Nas + Large Professor]

[Hook]
(Large Professor) One time for your mind, one time
(Nas) Yeah, whatever
(LP) One time for your mind, one time
(Nas) Yo, whatever
(LP) One time for your mind, one time
Hey yo, Nas? Kick that fuckin' rhyme

[Verse 1]
Check it out
When I'm chilling, I grab the buddha, get my crew to buy beers
And watch a flick, illin' and root for the villain, huh
Plus every morning, I go out and love it sort of chilly
Then I send a shorty from my block to the store for Phillies
After being blessed by the herb's essence
I'm back to my rest, ten minutes, some odd seconds
That's where I got the honey at, spends the night for sexing
Keep lubrication, Lifestyle protection
Htting up my stereo's remote control quickly
Ron G's in the cassette deck, rocking the shit, G
I try to stay mellow, rock, well acappella rhymes'll
Make me richer than a slipper made Cinderella fella
Go get your crew, Hobbes, I'm prepared to bomb troops
Y'all niggas was born, I shot my way out my mom dukes
When I was ten, I was a hip-hoppin' shorty wop
Known for rocking microphones and twisting off a 40 top, yeah

[Hook]

[Verse 2]
Right, right, what up niggas, how y'all? It's Nasty, the villain
I'm still writing rhymes, but besides that I'm chillin'
I'm trying to get this money, God, you know the hard times, kid
Shit, cold be starving make you wanna do crimes kid
But I'mma lamp, cause a crime couldn't beat a rhyme
Niggas catching 3 to 9's, Muslims yelling \"Free the mind\"
And I'm from Queensbridge, been to many places
As a kid when I would say that out of town, niggas chased us
But now I know the time, got a older mind
Plus control a nine, fine, see now I represent mine
I'm new on the rap scene, brothers never heard of me
Yet I'm a menace, yo, police wanna murder me
Heini Dark drinker, represent the thinker
My pen rides the paper, it even has blinkers
Think I'll dim the lights then inhale, it stimulates
Floating like I'm on the North 95 Interstate
Never plan to stop, when I write my hand is hot
And expand a lot from the Wiz to Camelot
The parlayer, I'll make ya heads bop, pa
I shine a light on perpetrators like a cop's car
From day to night, I play the mic and you'll thank God
I wreck shit so much, the microphone'll need a paint job
My brain is incarcerated
Live at any jam, I couldn't count all the parks I raided
I hold a Mac-11, and attack a reverend
I contact 11 L's and max in heaven

[Hook]

[Outro]
[Nas] Yo, from ninety-two to ninety-nine
[LP] Yeah that shit was greasy fat Paul, kno what I’m sayin?
But check it, you gotta another verse for me
I want you to kick it, you know what I'msayin?
Kick that shit for the projects"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "One Time 4 Your Mind", user_id: user_one.id)

lyrics_string =
"[Hook] x4
Represent, represent

[Verse 1]
Straight up shit is real and any day could be your last in the jungle
Get murdered on a humble, guns'll blast, niggas tumble
The corners is the hot spot, full of mad criminals
Who don't care, guzzling beers, we all stare
At the out-of-towners, they better break North
Before we get the four pounders and take their face off
The streets is filled with undercovers, homicide chasing brothers
The D's on the roof tryna watch us and knock us
And killer coppers, even come through in helicopters
I drink a little vodka, spark a L and hold a Glock
For the fronters, wannabe ill niggas and spot runners
Thinking it can't happen 'til I trap 'em and clap 'em
And leave 'em done, won't even run about Gods
I don't believe in none of that shit, your facts are backwards
Nas is a rebel of the street corner
Pulling a Tec out the dresser, police got me under pressure

[Hook]

[Verse 2]
Yo, they call me Nas, I'm not your legal type of fella
Moet drinking, marijuana smoking street dweller
Who's always on the corner, rolling up blessed
When I dress, it's never nothing less than Guess
Cold be walking with a bop and my hat turned back
Love committing sins and my friends sell crack
This nigga raps with a razor, keep it under my tongue
The school drop-out, never liked the shit from day one
Cause life ain't shit but stress fake niggas and crab stunts
So I guzzle my Hennesey while pulling on mad blunts
The brutalizer, crew de-sizer, accelerator
The type of nigga who be pissing in your elevator
Somehow the rap game reminds me of the crack game
Used to sport Bally's and Cazals with black frames
Now I'm into fat chains, sex and Tecs
Fly new chicks and new kicks, Heine's and Beck's

[Hook]

[Verse 3]
No doubt, see my stacks are fat, this is what it's about
Before the BDP conflict with MC Shan
Around the time when Shante dissed the Real Roxxane
I used to wake up every morning, see my crew on the block
Every day's a different plan that had us running from cops
If it wasn't hanging out in front of cocaine spots
We was at the candy factory, breaking the locks
Nowadays, I need the green in a flash just like the next man
Fuck a yard God, let me see a hundred grand
Could use a gun Son, but fuck bein the wanted man
But if I hit rock bottom then I'mma be the Son of Sam
Then call the crew to get live too with Swoop
Hakim, My brother Jungle, Big Bo, cooks up the blow
Mike'll chop it, Mayo, you count the profit
My shit is on the streets, this way the Jakes'll never stop it
It's your brain on drugs, to all fly bitches and thugs
Nuff respect to the projects, I'm ghost, one love

[Hook]

[Outro]
One time for your mothafuckin' mind
This goes out to everybody in New York
That's living the real fucking life and every projects, all over
To my man, Big Will he's still here
The 40 side of Vernon, my man Big L.E.S
Big Cee-Lo from the Don, Shawn Penn, the 40 busters
My crew the shorty busters, the 41st side of Vernon posse
The Goodfellas, my man Cormega, Lakey the Kid
Can't forget Drawers, the Hillbillies
My man Slate, Wallethead, Black Jay, Big Oogi
Crazy barrio spot, Big Dove, we rock shit, Ph.D
And my man Primo, from Gang Starr
'94 real shit y'all, Harry O, fuck y'all crab-ass niggas though"

Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "Represent", user_id: user_one.id)

lyrics_string =
"[Verse 1]
It ain't hard to tell, I excel then prevail
The mic is contacted, I attract clientele
My mic check is life or death, breathing a sniper's breath
I exhale the yellow smoke of buddha through righteous steps
Deep like the Shining, sparkle like a diamond
Sneak a Uzi on the island in my army jacket lining
Hit the Earth like a comet – invasion!
Nas is like the Afrocentric Asian, half-man, half-amazing
Cause in my physical, I can express through song
Delete stress like Motrin, then extend strong
I drink Moet with Medusa, give her shotguns in hell
From the spliff that I lift and inhale, it ain't hard to tell

[Verse 2]
The buddha monk's in your trunk, turn the bass up
Not stories by Aesop, place your loot up, parties I shoot up
Nas, I analyze, drop a jewel, inhale from the L
School a fool well, you feel it like Braille, it ain't hard to tell
I kick a skill like Shaquille holds a pill
Vocabulary spills I'm Ill plus Matic
I freak beats, slam it like Iron Sheik
Jam like a Tec with correct techniques
So analyze me, surprise me, but can't magnetize me
Scannin' while you're plannin' ways to sabotage me
I leave 'em froze like her-on in your nose
Nas'll rock well, it ain't hard to tell

[Verse 3]
This rhythmatic explosion, is what your frame of mind has chosen
I'll leave your brain stimulated, niggas is frozen
Speak with criminal slang, begin like a violin
End like Leviathan, it's deep, well let me try again
Wisdom be leaking out my grapefruit, troop
I dominate break loops, giving mics men-e-strual cycles
Street's disciple, I rock beats that's mega trifle
And groovy but smoother than moves by Villanova
You're still a soldier, I'm like Sly Stone in Cobra
Packing like a Rasta in the weed spot, vocals'll squeeze Glocks
MC's eavesdrop though they need not to sneak
My poetry's deep I never fail
Nas' raps should be locked in a cell, it ain't hard to tell"



Song.create!(album_id: placeholder_album.id, artist_id: placeholder_artist.id,
      lyrics: lyrics_string, title: "It Ain't Hard to Tell", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "More Gangsta Music", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Get Down", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Killa Cam", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Leave Me Alone", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Down and Out", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Harlem Streets", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Girls", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Soap Opera", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Bubble Music", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "More Reasons", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "The Dope Man", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Family Ties", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Hey Lady", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Shake", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Get Em Girls", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Dip-Set Forever", user_id: user_one.id)

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Take Em to Church", user_id: user_one.id)

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

