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

lyrics_string =
"[Intro]
Gangsta Music part 2. Dipset
Killa, Heatmakerz, Juelz Santana
C'mon. Lets Do It
Can I get a jeah, jeah, jeah, jeah
Everywhere jeah, jeah
Up, down, left, right, jeah, jeah, jeah, jeah
Shorty's movin again jeah, shorty's loose with the pen jeah
Shorty do it to win jeah, jeah, jeah, jeah

[Juelz Santana]
They say I walk around like I got a S on my chest
Tech on my left, gangstaz wit me ready to step. (Jeah)
I like a chick wit big breasts on her chest
Not flat lookin like somebody stepped on her chest. (Jeah)
What, (jeah) Shit, (jeah) Fuck, (jeah) Bitch, (Jeah)
You so crazy. (Jeah jeah jeah jeah!)
My niggas spit the Glock (oh so slow whoa)
Rude boi lick a shot (BO BO BO BO!)
Neva seen up in a pot (oh so much coke)
Cook it to a bigga rock (aye aye oh oh)
And I be wit dem gangstaz (jeah), I creep wit the gangstaz (jeah)
Crack a dutch or Philly and cheif cheif wit the gangstaz
I stay with a lady (jeah), she stay with a lady (jeah)
They makin me crazy. (Jeah jeah jeah jeah!)
I spray em wit babies (jeah), in they face till they hate me (jeah)
And I'm makin em crazy. (Jeah jeah jeah jeah!)
And they like when I do it (jeah), they like when I move it (jeah)
They like when I work it, they like when I hurt it
I stay icy on purpose, like icy perservers
More than likely I'm the nicest you hearda. Jeah!

[Hook]
I'm movin movin movin jeah! He's movin movin movin aye!
We movin movin movin jeah! Stop movin aye! Shot bruise em jeah!
Two more for Cam fa takin over the Roc. Jeah... Jeah! It's my year so
Jeah! It's like the whole Bird Gang's in here, like Kurt Cobain's was here
Jeah jeah jeah jeah!

[Verse 2: Juelz Santana]
Still listen to gangsta music (aye) how dem gangstaz do it (aye)
Shorty came to do it (aye aye aye aye)
I bang wit the five (aye) I see hate in ya eyes (aye)
You waitin to die (aye aye aye aye)
I pray for you guys, hate to keep waistin ya lives
Love to keep bakin new pies, strapin the scrapes off the side
You can love it (jeah aye) you can hate it (jeah aye)
You can want it (jeah aye aye aye aye)
I'm Babe Ruth in this game, beige coupe in the lane
State Troopers they came, damn he's movin again (aye)
I'm a better child, yous a pedophile (aye aye aye aye)
I go dough let around, my ho slow head around
They DTP's deep throat professionals
My D.I.P.'s we so professional
Got weed, coke, and ecstacy, lean, dope, and wet to sale
We blow jars of the dank, like Bob Marley was wake
Real shottas, fuck ya foreigners stay
I'm movin movin movin (jeah)
Y'all losin losin losin (aye)

[Hook]

[Verse 3: Cam'Ron]
I'm on the southside of Chicago lookin for a real ho
I dont see a touchdown, arms up field goal
Got some ill gold, diamonds thats still low
Lil dick you a dickhead, nah dildo
I chill though, pipping in the Range
All this icin I'm ashamed, look like lightnin' in the chain
Who was first that moved wit they fam (who)
Ask you, tattoos on they hand (who)
Slang all the white (who) cruise wit the tan (who)
Pink on they back (who) blue in they van (who)
Yellow on his ear (who) steam on the rock (who)
Puple in the air (who) green in his pocket
I ain't dissin' you dog, I'm dismissin' you
Get the R. Kelly tape and see how we piss on you
Thats Kool-Aid, Moutain Dew, and Cris on you
Ya family will be missin you, theres a kiss for you

[Hook]"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "More Gangsta Music", user_id: user_one.id)

lyrics_string =
"[Intro: Cam'ron]
It's like I'm psychic and shit
I called this shit about five years ago
Dipset all day every day
Santana, Jim Jones
Freekey be home '07

[Verse: Cam'ron]
Remember I'm a man of respect
Remember Santana was next
Now it's not techs, it's checks
And fancy collects
I want his wrist, fist, whole hand, jammed with baguettes
Pose for the camera man
Me and Santana man
Word to my grandma
He one bad mamma jamma, damn
So I don't write for the stardom
I get, booted, zooted, write down my problems
I've been through it headed right for the bottom
D.C. naw, would've been a sniper in Harlem (so what)
That's why I throw some dough
To my co-d from Kostovo
Help me get on overflow
No one suppose to know
But she lay me up like the prime minister
Thousand grams of dope smellin' like Hein Vinegar
That was a lot to linger
But to the top I bring her
But when it came to dope, I always copped in fingers
Money missin, oh shit I almost chopped some fingers
Slit some wrist, thats when they said oh shit he's not a singer
Fuck the rap, fuck the movies, fuck Siskel and Ebert
This pistol I'll squeeze it, missles if needed, Killa
Remember I'm gonna spend my cake
Remember Jim we getting out of 5H (projects)
Now chefs will fry us steaks
It's a higher [stake? / state?]
Swiss accounts I'm goin show you how to wire cake
And we from BBO
Now you a CEO
Direct a vee-ee-oh
Your own album here we go
Thats my man anytime I holla, holla with me
We shared chicken sandwiches they was a $1.50
Budget seven dollars, nickel bag and White Owl
I hope the chicken sandwich last us through the night child
We ain't care we didn't sleep we was night owls
Insomniatics our lifestyles compatible
Magical
Pops gone, shit tragical
Moms on mission
My house is where the addicts chill
I'm like a teacher, I need me a sabbatical
It's not irrational
I grew up radical
And you all are shook
I bought all my crooks
Fuck you R&B niggas Zeek sing all the hooks
Tito and Brick yes yes come again
They came sun or rain when I had that stomach pain"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Get Down", user_id: user_one.id)

lyrics_string =
"[Verse 1]
With the goons I spar
Stay in tune with ma
She like, \"damn
This the realest since 'Kumbaya'\"
Bomaye, Killa Cam, my lord
Still the man with the pan
Scrilla fan, oh boy and
Bitches, they want to neuter me
Niggas, they want to Judah me
The hooligan in Houlihan's
Maneuvering's nothin' new to me
Doggy, I'm from the land of grind
Pan pan: gram or dime?
Not toes or MC
When I say \"Hammertime\"
Beef: I hammer mine
When I get my hands on nines
If I had on 'Bama line
Corduroys, Cam will shine
Canary burgundy:
I call it \"Lemon Red\"
Yellow diamonds in my ear
Call em \"Lemonheads\"
Lemonhead end up dead
Ice like Winnipeg
Gemstone, Flinstones
You could say I'm friends with Fred
You unhappy scrappy?
I got Pataki at me
Bitches say I'm \"tacky daddy\"
Range look like Laffy Taffy

[Hook]

[Verse 2]
I'm from where Nicky Barnes got rich as fuck
Rich and A hit the kitchens then were pitchin' up
Rob Base, Mase, Doug E Fresh switched it up
I do both, who am I to fuck tradition up?
So I parked in a tow-away zone
Chrome...I don't care
That car a throwaway, homes
Welcome to Harlem
Where you welcome to problems
Off of furlough, fellow felons get pardons
Them niggas newbie bang
Stood out like Pootie Tang
Soon as the stoolie sings
That when the toolie sing!
Bang! Bang! came from that movie ring
Snap, crack jewelry bling
Flapjack, ooh he bring
Clack-clack, \"ooh he ring!\"
Bad rap, cuties cling
Ass cap, put em in the river
I'm the sushi king
And I'mma keep ya fresh
Let the fish eat ya flesh
Yes sir, please confess
Just say he's the best

[Hook]

[Verse 3]
How dope is this?
Teach you how to rope a chick
What you want: coke or piff?
Got it all, smoke or sniff?
And you know my drift
Used to figures, dough and shit
You a rooster nigga
This a roaster, bitch
And I roast ya bitch
That's how it usually ends
Tell her and her groupie friends
Go get their coochie cleansed
We the moody Gucci, Louis and Pucci men
Escada, Prada
The chopper it got the Uzi lens
Bird's-eye view
The birds I knew flip birds
Bird gangs, it was birds I flew
And word I blew off herb I grew
I would serve on stoops
Now swerve in coupes"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Killa Cam", user_id: user_one.id)

lyrics_string =
"[Verse 1]
I be like: \"Move! get out the way\"
Cause I move bricks, get out the yay
And it's 2 clips, I get out to play for
Few chips, I get out n' spray
It's more then shrimps, it's whores and pimps
The difference in our crimes, yours attempts
Attempt burglary, attempt theft you just begun
I'm Grand Theft Auto, racketeering, larceny, conspiracy, murder one
Electric chair I don't deserve the fun
But I get the dough, shit I might splurge on one
Now I know a lotta styles, some see
But listen, stop it child it's a done D
I come to ya block, stop it's that one D
Gators straight from Crocodile Dundee
No rubber sole, hardwood bastard
Fitted, legitted, hardwood classic
Killa! Uh!

[Verse 2]
Uh, that shit you talk don't move me nada
The dudes with the Q's be proper
Uzi pop, you news and choppers
It's truly liver, who knew we'd prosper
The game's a bitch, ooh we got her
Shoes, Louis, Prada, groupie blah blah
Santana, Zeek, the kufi poppa
We the movie Shottas
But it's really rude bois and rastas
With a Trailer Load of Girls, excuse me Shabba
I wish my homie could watch me
Live Happy Days like Joanie and Chachi
I stay lonely and cocky
Dice!
Rollin' and rollin' 'em
Cars, the repo are towin' 'em
Ask black, we totally total 'em
Even Blood, he totally totaled it
Plus his life, he totally totaled it
But any girl I get I totally open 'em
Brain and they legs, coke and the dope in 'em

[Hook]
Killa!
Talkin' tough? (Yo!), smokin' dust (Whoa!)
Fuck with us? (No! No! No!)
Get ya head bust
Get ya head bust
Fuck around dawg, get ya head bust
He talkin' fly (Yo!), I wonder why (Whoa!)
Fuck with us? (No! No! No!)
Get ya head bust
Get ya head bust
Fuck around dawg, get ya head bust

[Verse 3]
I spend days on Kawasakis
Nights with Lewinsky
But I'm the like the Ice Man, Michael Kuklinski
I style on New York, pile up my fork
The Dips, consulted by the son of Malachi York, doggy
Cause I push weight, plus I push tapes
God damn I'm starvin' and I just ate
I wouldn't say I'm Nino with The Carter
I'm more like the plant in Little Shop Of Horrors
But I don't say \"Feed me Seymour\"
I say, \"Feed me Dame, feed me Lyor\" (billions!)
Epic, they used to feed me detours
Roc-A-Fella, they feed me C-4
The way I blow up, the VS just soars
You GS-3, I'm GS-4
You in a Lexus, I'm Gulf Stream 4
Up in the sky, on a gulf stream tour
You want beef? We'll start a Gulf Stream war
Lay ya ass down on God's green floor
We playin' golf in the Gulf Of New Mexico
The cost to be the boss, you gotta respect it, ho
My gas game you gotta respect it tho
I swear to god you think I'm workin' for Texaco
And ya section know when any day Tecs could blow
Hit 'em from neck to toe when I come deck ya ho
Killa! Dipset Bitch!"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Leave Me Alone", user_id: user_one.id)

lyrics_string =
"[Intro]
Killa! Baby!
Kanye this that 1970s Heron flow huh?
Yeah let's speed it up

[Verse 1: Cam'ron]
Ayo street mergers I legislated
The nerve I never hated
On murders pre-meditated
Absurd! I hesitated
Observe: cock and spray
Hit you from a block away
Drinking sake on a Suzuki we in Osaka Bay
Playing soccer, stupid, stay in a sucker's place
Pluck ya ace, take ya girl, fuck her face
She dealing with Killa so you love her taste
She swallowing Killa cause she love the taste
I got brought up with crooking
Kitchen orders that I'm cooking
But got caught up with the jooks you woulda thought I was from Brooklyn
It gets boring just looking
Did like Bill Cosby, pouring in the pudding
Now the dashboard is wooden from a hard-tangled grammar
Interior, inferior, star-spangled banner
Car game bananas
My man Santana
Guns everywhere, like the car came with hammers

[Hook: Kanye West]
They trying to say he (down, down)
I hear niggas saying he (down, no no)
But our flow is the truest
The games in the nooses
Our girls is the models
They coochies the juiciest

Yeah, they say he (down, down)
Yeah, they say he (down, no no)
Cause I’m back on my grind
Money back on my mind
Ye' and Killa Cam', the world is mine

[Verse 2: Cam'ron]
I treat bitches straight up, like Simon Says
Open vagina: put ya legs behind ya head
Cop me Air Ones, hon, lime and red
You got pets? Me too: mine are dead
Fox, minks, gators that's necessary
Accessories, my closet's a \"Pet Sematary\"
I get approached by animal activists
I live in a zoo
I run scandals with savages
All my niggas get together to gather loot
Bodyguard for what? Dog, I'd rather shoot
I go to war, old Timbs, battered boots
Hand grenade, goggles and a parachute
Ya'll don't even know the name of my flip
It was \"Touch Me, Tease Me\" when Case was the shit
You don't know bout the cases I get:
Court case, briefcase, suitcase, cases of Cris

[Hook]

[Verse 3: Cam'ron]
Ayo you dealing with some sure shit
My bitches pure thick
Play razor tag, slice ya face, you're it!
It's I who come by drive-thru
Gator-toed Mauri, three quarters, sky blue
Look at mami: eyes blue, 5'2''
I approached her \"Hi boo, how you?
Pony skin Louis? Oh, you fly too
You a stewardess? Good ma, I fly too\"
Now a nigga got baking to bake
Harlem Shake? Nah, I'm in Harlem shaking awake
Shaking to bake, shaking the Jakes
Kill you, shoot the funeral up and Harlem Shake at your wake
Just ya picture though, you still taped in a lake
I'm laughing; you couldn't wait to escape
For anyone who owed the dough, I had to load the fo
I hoped a nigga heard when I said \"I told you so\"

[Outro]
Mine
Killa you already know Harlem
Whole Midwest, Detroit, Nap town, St. Louis
Chicago of course
Westside, holla at me
Southside wild hundreds
You know what it is Ohio
Columbus, holla at ya boy
You know what else I do:
Dayton, Youngstown, Cleveland, Cincinnati"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Down and Out", user_id: user_one.id)

lyrics_string =
"[Verse 1]
We tie dynamite to the rhino type
Wino might find yo' sight
Sell the information for a dime of white, that China-China
I'm behind the diner, selling marijuana to a minor-minor
Elder fella; looking for that shine? I'll shine ya
My mind designa. You a dime? I'll dine ya
Madonna momma, body bottled, you're fine. I'm finer
Time to climb her, climb behind vagina
Then I hymen-grind her 'til her mom remind her
Diamonds blind her; vision's gone, kiss her palm
Turn her arm, lift her arm, notice that her wrists is wrong
\"Gotta get it right ma, we gon' get along\"
Said \"how?\" \"don't trip,\" but, yo, the trick is wrong
First visi-on, day job tick-a-tron
Nighttime, Mr. Mom. Bootleg Cris and Don
Brother Chris and Don, and their sister Carm
They sell yey, you'll say \"yay, this shit's the bomb\"
I'mma hit my man, tell 'em you my pick upon
The rest, so yes, you'll be blessed to hit the intercom
You know, kiss his mom. She gave him wisdom charm
And their father come from a long list of dons
And I get it cheaper, I cop bricks like sneakers
And if the cops come, I just hit amnesia
But I give you an earful, it's tearful
Told my mother I hustle and she said \"be careful\"

[Hook]
Why I feel like I'm losing weight?
Why I ain't got no money if I'm moving weight?
My life's based upon what I'mma do this year
Cop a boat, cop a Lear
Now the army suit's cute with my chocolate Airs
You ain't gotta stare, go cop a pair
Still the scrutiny, nothing they can do to me
I made sure my mother and girl is smothered in pearls
When a nigga under the world

[Verse 2]
Everybody like, \"Cam got the recipe now!\"
Not them 3 girls I got to be Destiny's Child
Specially equities, reckon we smile
In the fear, tech the tech and use the tech that we wile
Detective deceptive, receptive of fouls
Hectic, Heckler & Koch
Helicopters on the set of my sales
Nah, I ain't gonna be embedded in jail
Talking to a cellmate in a bed in a jail, dog
I broke bread with the whale, fled from some seals
And the house, I was the head of the hills, shit
You get a dumb ho, and get dumb-happy
Go to the gun show, get gun-happy
Stuck, killed, mugged, milled
Tone, flint, sticks, bo, Chub's milk
Pucci baba, but I got the hardest shells
We the Midwest gun cartel nigga
Ya, we'll just clap up your brains, snatch up your chains
See dog? Rap is my aim
But I'm a hustler, in my heart, trapped is the game
Attached to my frame, tapped to my brain, the fact still remains:
It wasn't rap, it was crack that got the racks on the Range
Look dog, don't be asking for Dame, see
Playboy, I don't own that man
And anyway, homeboy, you a grown-ass man, shit
And when I rap it ain't no punchline
I be on the highway dirty, crunch time
No timeouts homeboy, just one time
If they find that stash box just one time
Shit, they'll put the dogs in the truck
Side of the road, holding you up, cold as fuck
They want that button, lunge it and push it
Soon as they lunge it and push it, I run in the bushes
That's how I play mine, jump over the grapevine
Take my chances one-on-one with the K9
Stealing a clip for anyone squealing they lips
Fuck y'all if y'all ain't feeling the Dips"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Harlem Streets", user_id: user_one.id)

lyrics_string =
"[Intro]
Killa!!
Dipset, Charlemagne
Jim Jones, Santana, Freekey
Let's go! What they want sing

[Hook - Mona Lisa]

[Verse 1]
Damn chump passed, he a dumb ass
Call J.R. (why?) get a fun pass
Yeah she come fast, so she leave quicker
Cause she cum faster, skeet skeet nigga
We be with her, me, Jim, Zeek, hit her
Then she with flea flicker, don gg get her
P.E wit her, wee wee, eazy, ol me, ol g little me lick her
So she need liquor, never seen sicker
Nigga, if rap was head, she could be Twista(fast)
Had her alley to alley, Hawaii and Maui, and Cali the Valley
Up in white Lotus, dog you might notice
That you type bogus, me I'm quite focused
And hope is hopeless, disappear in the air, hocus pocus

[Hook]

[Verse 2]
Goddamn he stuck like stucco
Cut low, slut no, here he come uh oh
Man see what the fighting do that's why I'm piping boo
Ain't even liking you, I'm exciting true
Just right I do, heels high, wheels fly, real fly Nikes are new(Air 1's)
And a righteous view, from night to new, day, hey play
Catch a flight for two (first class!) and you thought you a baller. A baller?
Hawker, dog you a stalker! (you a stalker)
Upset cause what she wear showin'(that's see through)
Aww man you ain't in gear for knowin
Ask questions in fear of hoein'
What's that? Who you wit?, where you at?, where you goin'? (where you goin'?)
Where you goin', I'm flowin', she blowin', sky high like a Boeing
Got pies like it snowin' (slingin'!)

[Hook]

[Verse 3]
Females better twirl on yours, better curl on yours
Cause I swirl on shores (then what) come back to a pearl golf course (who you)
I'm corrupt, cause girls all whores
And the world is yours, honey sip sizzurp earl of course
And you know I'm in the building mister
With the Olsen twins, or the Hilton sisters
And I haul 'em in to the Hilton mister
I milked them, I killed them, you quilt them, you missed her
You held her, you kissed her
You felt all the blisters, melt on your whiskers

[Hook] - 2X"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Girls", user_id: user_one.id)

lyrics_string =
"[Hook]
If only you could let me in
I know that love it could begin
If only I could rap to you
I know this love would capture you, yeah

Don't you wanna ride?

[Intro - Cam'ron]
Killa! This the ghetto soap opera right here man
You from Harlem you already know
You on that hustler's mission; you trying to get that paper
Wifey like it one minute next minute she don't, man
You know they at home watching Lifetime or on the Internet

[Verse 1 - Cam'ron]
Yo my mommy Toy was my pride and joy
She would drive the toys plus ride the boy
To supply the boys I got it live from Croix
Yes a nine in boy, wore a five in boys
Over the chick shit I shoot five with Roy
Now I load the 4-5 shoot five at Roy
Ain't like my job or guys I employ
Lifestyle I enjoy but I'm the livest doy (doy)
A hustler and Cam famous, you damn anus
I don't know but I can't change it
Can't paint it; pop it, champagne it
Stop it. Car: drop it. It look dull, damn, paint it
She would throw a pout how I'm showing out
How I'm outgoing but don't be going out
It's things to know about when you got dough and clout
Ways to move, know the route. \"Babygirl, close your mouth\"
Cause I feed you well. Every sneaker, hell
You eat Louis, shit Gucci, breathe Chanel
Karl Lagerfeld acting like Gargamel
For the car cop the cell in the bar stop at hell
\"What's wrong with you?\" She said, \"what's wrong with you?\"
Always got a song to do can't get along it's true
So I skipped marriage, bought her six karats
Rather die that nigga than to live average

[Hook]

[Verse 2 - Cam'ron]
Looking back on school: art and crafts
Fucked half the staff, beat up half the class
I was like Dr. Dre, though, I have to laugh
Nigga with a attitude, meet me after math
Had a \"half and half\"
Not a drink -- two chicks that flip acid fast
The half a tab
You could ask her ass, I would dash and laugh
You after me, huh? I'm after cash
I'm on I-80 though with my baby
Whole ride hazy tell her don't drive crazy
I got plans for you look in the sky baby
Fuck Sara Lee, Mrs. Smith; you the pie lady
Fly lady G2 fly baby gee you why baby
Please boo what's your size crazy
Don Juanin' when I'm in a foreign
Almond drop top my charm is alarming
I was alerting her just to reinsert in her
That I will leave earth with her
Huh, I can't interpret her
She got mad I leaned over, I'm nursing her
Said when I do dirt wit her
The only time I flirt with her
Not to be V.I but this is B.I (B.I)
Me and G.I be watched by the P.I's
See why we can't finish together
I'd rather do business than pleasure
And that's real (Killa)

[Hook]"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Soap Opera", user_id: user_one.id)

lyrics_string =
"[Verse 1]
Mommy all on me cause I'm touching her belly
I'm on butter Pirellis
Whip purple and yellow, hello
That's butter and jelly
I flip butter on cellies
All right in front of the deli
Holly, Lilly, to Kelly all spent ones on the telly
(and what else) and I got hella gear
My earring is nice, the price:
Three town homes in Delaware
Uh, tomato Porsche looking like tomato sauce
Hip hop hooray I got to get that yayo off
That's blocks to the ave, cops come blocking the ave
I put the Glock in the stash, slabs and tops in the trash
Still stop and I laugh; ma, get them rocks in your ass
The rest? Twat in ya bag, dag, hop in a cab
Play you, for what? You gonna play yourself
Ain't nobody gon' pay you like you pay yourself
And my way to the wealth was SK, AK, mayday, payday
Dog, don't play with your health

[Hook]
Mami... she open, she open
Jump off... hoping, I'm hoping
Grab her... rope 'em and dope 'em
Oral... choke 'em and choke 'em
I flip bundle to bundle, trying to double my double
At the same time.....[Music I bubble]
But the cops say I'm [looking for trouble]

[Verse 2]
I get fresh from Yankee stadium to the garden
I beg your pardon, stop it
My closet: Macy's men's department
Pants, shirts, scarf, phone if you check it
Get the scoop on the cologne, belt, and shoe section
Fur for fur, baby; baby, you'll go stir crazy
Got that David Yurman burning, the bird gazey
You'll get hurt, play me
Burp, let the dirt chase me
Every third lady that flirt, want my chirp lately
I know some RN's that still strip
When I and this real dick in the clinic
Nurse suit and heels, shit
Better than college, after that, students home
At least after your bid, ain't no student loans
To pay back, jack, ask, \"What do you condone?\"
Hit towns with coke, a .45 blue as chrome
They done juiced my dome, knock knock, \"are you at home?\"
I'm Macaulay; girls call the crib and ask, \"are you alone?\"
.....killa

[Hook]

[Verse 3]
We race foreign cars, custom models
Drop top mustard Tahoe
We like the musketeers, trained by Cus D'amato
Just the model, a dozen hollows is tough to swallow
Watch Sanford and Son, I'm like the buzz in Rollo
Fortunado, the Porsche Apollo, wars'll follow
Got the Mac jack, still swing swords like Zorro
We jacking and clapping, y'all just applaud like \"bravo!\"
Now applaud the capo, Zeek and Santana
I don't raise her wrists, I keep eighths of piff
The game's a chick; I'm Kobe, I'mma rape the bitch
Razor grips, laser spit
Glock cocked; J or fifth?
D on the block just like Jadakiss
Haters shift, plead the fifth
Spray the fifth, gator kicks
Matrix, major chips
I'm your favorite
Killa

[Hook]"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Bubble Music", user_id: user_one.id)

lyrics_string =
"[Verse 1: Cam'ron]
Yo, uh, I rock baguettes with hoodies, it's like extra goodie
I couldn't break dance ya'll, or electric boogie
I was obsessed with Cookie, I wanna sex her cookie
She said forget her nookie, wipe my nose, go get them boogies
I gave Cookie nookies, with the girls, got known
This my two brim hat, call me Sherlock Holmes
Whole world got blown, so I tell hoes
Fuck Lee's and shell toes, Dekangaroos and Velcro
Timbaland, moccasins, dimes in them pennyloafers
A-Train, one bus, sure I had plenty soldiers
Uncle, plenty holsters, dolgers, soldiers, hostess
Not golfin' like golf, he had plenty gophers
Can't get paid in an earth this big?
You worthless kid, Cam don't deserve to live
Back then I played for Gauchos, went over the riverside
Young life, turned left, we back over the riverside
Blood played for Stone Gym
That's when I told him and Jim
We ain't balling for real, where's the stone gems?
Where's the chrome rims?
That's when you changing lanes
Here we change your lane, we'll gain a sprain
Change the game
And not naming names
But 'caine fames like Damon Wayans
Connect for life is, the Tech kept us righteous
Cause yes expect the crisis, when it's connects and prices
I had to hustle harder, move up my muscle martyr
Seen New Jack City, cop me a couple Carters
And that's word to my father, send a bird to my father
Dove love, R.I.P. on his early departure
I'm just merely an author, but I'm purely a baller
Every Friday, across the street, and I creep with Ms. Parker

[Hook: Jaheim]
Get the whips the kicks, and clothes
So we can get with the models
And hit the strip with the Dip, we're 'Set to blow
Now you know
All of the reasons why we chase the doe
Get the whips the kicks, and clothes
So we can get with the models
And hit the strip with the Dip, we're 'Set to blow
Now you know
All of the reasons why we chase the doe

[Verse 2: Cam'ron]
Killa
That nigga man, let me break it down real simple for ya'll
Listen, yo, and I'm very prestigious
You have various leases
All my pieces, painted them, cherry and peaches
Chics, Cherry and Peaches
They had cherry deheaters
If I want a toast, hustled up various reefer
Ithaca, Ithaca, hydro, why yo?
Haze on delivery, lives hoes, five fo
But kept the fo-five, for wise guys with eyes low
Pick me up from fo-five, CL-55, whoa!
Playin' Grand Theft Auto, they like Diablo
My crews' the triad, Zeek, Santana, Capo!
But they some slimmies who
Can rock a Jimmy Choo shoe
Next day velour sweatsuit, construction Timmy boots
Don't be no guinea boo, you rock that Fendi you
You drinkin' Henney too
Coupe color as Winnie Pooh
And he skinny too, they had my favorite rum
Not a six-fo-five-fo, but made in jump
Shout, say say the funk, he keep the K in pump
He ain't never scared, never scared, raise the trunk
We'll just lay and dump, play the punk, spray the chump
The way they running I guess they could relate to Gump"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "More Reasons", user_id: user_one.id)

lyrics_string =
"[Verse 1: Cam'ron]
How I get robbed in Cali, I be with Cali thugs
Got mobbed in Cali, yeah, that Cali love
Come on chatter mouth, have my bling black is out
Stick me what that about, I was the only rapper out
Beverly, Foxhill, Roscos, swap meet
Slausson, Crenshaw, Compton, we not sweet
Like I'm chump change, Jimmy with his dun game
I'm fun aim, LAX gun range
White load the felly fell, holla at the kid proper
If somethin happen, skip rappin, they'll be big choppas
Ghetto byrd word, cause I keep the big choppa
No disrespect, niggas killed Big Poppa
The Williams sister, Romeo from Steve Harvey
Got the drop, get the drop, no please sorry
Got weed on me, no need guard me
I'm what you need probably, I teach robbery

[Hook: Jim Jones]
We ride in that east side
Please roll up my weed high
We ride in west side
The city were them techs fly
That dirty dirty south side
Midwest uptop when we outside
But we ride in that eastside
So please roll up my weed high

[Verse 2: Jim Jones]
My momma always told me aim for the sky
So I, came out bangin and aiming at guys
It was, mainly slangin that caine by the pies
And the, fiends was payin for dangerous high
Blow, peep and ammonia, we mix it down
There's no sleep on the corner, the pitching mound
And police, when the saw us they frisked us down
We hold heat, marijuana, they lick it down
So tell Bloomberg it's a wrizzy
I take it back to '88 and move birds though my city
G.W. Bridge, New Jers with the pizzy's
28 a key, the suburbs, they get busy
And fuck the phones, get the word by mouth
When the winter roll around, know the birds fly south (Miami)
And fuck the cops, got hella folks up in prison
Had no other option but to sell coke for a living

[Hook]

[Verse 3: Cam'ron]
Dope man, Smoke man, O's float the coast damn
No coke and postman, slow jams, cokeland
Throat jams, throw grams, no maams
Sell white throw tan, tell her (ill holla)
Watch the kid from 140 bake
They say shorty straight
28 grams, Turn 4 48
?? ?? bought the cakes
?Lore? off of 4 to 8
All I do ignore the jake tell her (ill holler)
I still bubble o's, still double those
Still double my double down in the double o
From the CEO, love gets sent to them
Akron, Springfield, Cleveland, Cincinnati
That's Detroit, Minnesota, Greenpoint
Naptown, Sactown, The Lou gots some mean joints
We orangutan it, ?Durange? bang it
I'm strangly ganged
Like Pac I'm Gang Related (holla)

[Hook]"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "The Dope Man", user_id: user_one.id)

lyrics_string =
"[Verse 1: Cam'ron]
Man I spit that pimp talk
You hang out where the pimps collide
It's a pimp in my ride, no need to pimp the ride
This ain't the pimp camp: pimp limp, pimp stance
Pimp-slap a slim tramp. Order steak, shrimp scamp
Ok-k-kay, you g-g-gay
I'll soufflé ya toupée and bottles be a bouquet
Right where you stay
(Or where you stayed)
A 45 trey deuce spade sprayed, you stayed
Unload the click-clack to ya fit cap
Hold the shit back, say goodbye and go commit that
For 9 years in Spain had the time share
Back to Times Square...I got dimes here
By the Port Authority, but I got more authority
Your girl she ordered Mauri, checks she forge 'em for me
Reporters report me how she report to the orgy
But it's more to the story: her daughter applaud me

[Hook: Nicole Wray]
We in the zone, our soldiers like to stand by
Never alone we 'bout to make the drums cry
Dipset, dipset
We hold our own, don't think you can move us or push us
And step to the side, that's why they call us \"family ties\"
Dipset, dipset

[Verse 2: Cam'ron]
From the back of the cop-ride
To black-on-black, black when we cop rides
I will not hide, \"hi ma, hot thighs\"
Dick on her nose...now she's cock-eyed
From whippin' the bacon rolls to outside whippin' the bacon Rolls
Annihilatin' those, I'm rakin' but makin' dough
80 holes in your shirt, there: your own Jamaican clothes
I ain't talkin' the Poconos, I'm talkin' the Aspens, to slopes we go
You get the \"okey doke\". Play me, baby I hope he know
We break noses, call him baby Pinocchio
(Fuckin' liar)
I hold him with blue mittens, 2 pigeons, \"what the fuck are you pitchin'?\"
1 house, 2 kitchens...who's bitchin'?
I bring the diesel, won't see the Fu-Schnickens
And I don't trust a ho
That's mother to baby-mother
Motherfucker, you look like a lady-lover
I'll touch slap her, dap her, plus clap her
Tell her drink, come get drunk, it's nut cracker
And it's well known that Rell home
Yup, hit E.T up on the cell phone
As your family dies, and my family rise
Call the network Dipset Family Ties

[Hook: Nicole Wray]

[Verse 3: Cam'ron]
They see me in that lavender tank, you'd rather just faint
I was Fort Laudi, you was Saint Latter-Day Saints
Whips get lathered in paint
Rap with the rappers, scrap with the actors, cap back: abracadabra
And I'm apalled think that we at all comfortable
Me in Mauris, these rappers all Theodore Huxtable
Their mother's a lawyer, their father's a doctor
Auction coke to the coppers, Glocks in the locker and
Who you supposed to be?
Get hung from the rosaries
Call me \"C.O.D.\" - that's coke and them Os of D
Some O.D.ed, B off them Os of D
I ain't give a fuck as long as they ain't close to me
Put ya drugs in the air, give a toast to me
Pump that dip in ya veins, get dope like me
Fuck Kerry and Bush, you should vote for me
For real, nigga, on the real the last hope is me"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Family Ties", user_id: user_one.id)

lyrics_string =
"[Verse 1]
I know you heard me in British Raj
But I get you bracelets till ya wrist is throbbed
Just kiss the knob and put your meat on my stick like a shish-kabob
Out mingaling, heard that I blingy-bling
But I run the circus like Ring-a-ling
I'm the king of things.. And your man, he a homo like Ching-a-ling
That's life, hit 'em with the pow-ping
Pow, pow, .45 loud thing
Look wild thing, I do wild things
Make China stretch like Yao Ming
Ching chong chinga-linga - ciao, meng
I'm bilingual ma, I don't need a nickel, naw
Oh you tickled ma? Cause your nipples huh
Comming through your shirt, nearly ripped your bra

[Hook - Freekey Zekey]
I see the hate in your eyes, damn them boys is too fly
The way we roll up, rims all swoll up, ice all froze up
And while you're acting surprised, like we don't sell them pies
They way we hold up, papi hole up, mami roll up

[Verse 2]
I know you in school and work, but you need to get schooled in work
Put my tool to work; I'm feeling your shoes, your purse
You get low on dough, refuel the first
I don't need you high like I'm high
But shit, I need you fly like I'm fly
Fresh Louis Vuitton ankle
Pastel Louis Vuitton rainbow
Threw on the Kangol, threw on Durango's
Not from the 'nati but threw on the Bengals
Moved on an angle, like a bull and matador
The two gonna tango
Shake your body mami, move your body hottie
Its true I'm kamikaze, I move in a Mazerati
They all polly-polly, woo boy, dolly-dolly
I don't talk unless you swolly mami

[Hook]

[Verse 3]
Lady, dry your panties
Damn, she wanna write her family
Tell her Dad I'm a diaper dandy
And I got all type of candy
Whats that? Victoria Secret?
Here's La Perla, come peep it
This lingerie that you could honor
A Wonder Woman, ouais, go on and play
Like Cam' watch, like Cam' ring
Like Cam' chain, like Cam' bling
Heard Cam' sing if a damn fling
Goddamn mam', not a damn thing"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Hey Lady", user_id: user_one.id)

lyrics_string =
"Killa! Jones! Freekey! Santana! Come on!
Shake, shake, shake (uh!)
Shake, shake, shake (Uh!)
Shake, shake, shake (uh!)

[Verse 1: Cam'ron]
Yo, who wanna mess with me, or come mess with me
Be a mess to clean, call me Mr. Clean
The way I glitz and gleam, trigger team
Click the Beam, hit the fiend (?) on me
Lookin like I'm nicotine
But it's all for the green like Listerine
Had to diss the queen thinkin I'm gon' get her jeans
I ain't Ginuwine, ma, my mission's mean
All my nigga team fix the fix get the cream
I sit in Bahamas, with Alyssa Milano
Got the Crist' and the ghanga and its gettin un-karma
Comma, now she cryin she missin her mama
Just a steppin stone for me now I'm hittin Madonna
And she twistin the fauna as we sit in the sauna
Guess it's just my persona, got her kissin my condom

[Hook]
We're the Dips, so cut the shit
Ma, twist your hips and lick your lips
We're the Dip, so cut the shit
Ma twist your hips and lick your lips

[Bridge: Cam'ron]
Ma you straight frontin', let's get the date jumpin
See your booty panties, ma shake something
Shake something, shake something
Shake-shake, shake shake something

[Verse 2: Cam'ron]
And I got some girls, bout five or six
And a five and six, about five or six
I surprise the chick, that's when her eyes get lit
Let her drive the whip, see if she ride a stick
Who as live as this? My pool size is sick (sick)
But swim in my pants and dive for dick
They call me Moby, my pos-i-tive
Tell them free Willy if your thigs are thick
And your ass if fat and your head is right
And your dough is good, we can smash tonight
Right here in the car, ma, at the light
If you ask for cash, oh I'm mad for life
Kiss ass, you dyke, and I'm fast to fight
If you get mad, (??) grab a bite (what?)
Or I stab it light and we'll grab a bite
Is it crab you like? Lobster appetite

[Hook]

[Bridge]

[Verse 3: JR Writer]
In front of the club, drops, coups and trucks
I'mma front in the club with a hundreds of studs
A gun and some bud through the metal detector
The metal detect ya, settle and wet 'cha
I don't mettle with extra, you fakes and clowns
I walk in and get out of the club safe and sound
Silencer, dog, how safe it sound?
I got apes and hounds, he just pace around
And I'll lace you down, but I'm lookin for
A Manahttan ho or a Brooklyn whore
A Bronx biatch that'll let me look and explore
Up front but beat around the bush for sure
'Til the toosh is sore, hit it doggy style
Get it doggy style, you know your doggy's style
I'mma mack or more and it's smash or more
A VIP up between the bathroom stalls

[Hook]

[Bridge]"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Shake", user_id: user_one.id)

lyrics_string =
"[Verse 1]
I get the boosters boosting, I get computers 'puting
Y'all get shot at; call me, I do the shooting
I do the recruiting, I tutor the students
I nurture their brain, I'm moving the movement
Whether Buddhist or Buddha, that's Judas or Judah
I got Luger to Ruger, hit from Roota to Toota
Chick from hooter to hooter, I put two in producers
I'm the real ball story, the loser of \"Hoosiers\"
I rock mostly dosey, I roll mostly dolie
I'll leave you wholly-holey, you'll say holy moly
Here come the coroner, get em, play Rollie Pollie
I'll tell you true stories, how I coldly hold heat
When it's repping time, I get on extra grind
Fried to fricassee, Pepperseed to Pepperdine
Jeff Hamilton, Genesis, leather time
Bitches say I'm the man, I tell em never mind

[Hook]
They getting nice, they got some ice
Let's get the dice and roll em (get em girls)
They getting chips, they flipping bricks
Get the rots and pits, tell em (get em girls)
She acting feisty, getting sheisty
Call the wifey, tell her to (get em girl)
Just lay back, get your face slapped
We at the race track, eight stacks (get em girls)

[Verse 2]
You acting funny nigga
Come dumb, dummy nigga
Killa keep twenty blickers (I'm getting money nigga)
So you should move away, or join the dude 'n play
Hey, so you can say (I'm getting money nigga)
First pile up in the rear, I style up in my gear
Stallion of the year: medallions in my ear
Whips on my fists, houses on my wrists
Your budget on my neck, your spouse on my dick
Posters on the wall, posted on my balls
Dick in her mouth, I tell her \"I'm gettin money niggaa\"
Y'all faking the fizzle, I'm caking for shizzle
Fuck a Sizzler steak; my estates, they sizzle
Ate, boom-boom, my ace boon coon
Shake, bake, skate, vroom vroom (We gettin money niggaa)
7 to 8, zoom zoom, boom boom tune
'Fore I get life, that boom boom room (I'm gettin money niggaa)
Wrecks 'n Effects: zoom zoom in poon-poon
Since the movie Cocoon, had my Uzi platoon (I'm gettin money niggaa)

[Hook]

[Verse 3]
My team is the Goonies, we were seen with buffoonies
Toonies, best dressed, stay up in Neiman's and Bloomies
Want to hit it from the back, she agreed that I'm looney
But proceeded to moon me (I'm gettin money niggaa)
\"Baby\" b.s. and \"honey\" do, Cam V.S. 1 and 2
I'll help you get your son out of P.S. 22
Get him a Mauri flow, from the Mauri show
Fuck around, y'all gonna be up on the Maury Show
He in bootcamp, you on food stamps
Welfare, no health care, a true tramp
And I'm lokie-lokie, leave you pokey-pokey
No Rice a Roni, that's the okey-dokey
Me and Toby homie, make you do the hokey-pokey
Pull the pound, up and down, turn yourself around shorty
Here's some weed, burn yourself a pound whoadie
Here's a map, go learn yourself the town, sporty
I was down 40, now I'm up 50
Buck 50, but quickly: who could fuck with me?"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Get Em Girls", user_id: user_one.id)

lyrics_string =
"[Intro]
Let's do it!
Santana, Jim Jones, Killa, Freekey
How long we gon' have this shit on lock, man?
Yes sir, you gave me the right track Kanye

[Verse 1]
Listen, I been coppin them P's and
Maybe that's part of the reason
I feel like a boxer: bobbin and weavin
But I'm getting head
She's bobbin her weave and (yes sir)
I'm grabbin her neck to stop her from breathin
I'mma wild out until I part with my breathin
Until I'm sparked up and leakin
Part of the cement
I need something pure, like from the Garden of Eden (why?)
Wouldn't mind making her part of my achivements (what happened)
Cause when music discourage my pride (who was there?)
Zeke the only one with courage to ride
The ride's so dirty inside
Seems like we were playin in mud
Hazin' it up, grams, gauge and a snub
Who ill? a check for two mill
And a cheap case, defaced, blue steel, true skills
I got stories that my soul can sing
Flip water like Poland Spring
And I'mma hold them things

[Verse 2]
Look - talk to 'em
Look - my fella said you been coppin' a lot
Latest caper? Propellers on top of the drop
But fuck it, who ever thought I would rock at the Roc? (Killa!)
Top a top on top of the top
But yo - nothing definite
I chop up the rocks
And I stop up the drop
Blocka Blocka the block
Hello mate, yellow tape, helicopter your spot
What you wanted is not what you got
And I pop up them cops
Cause dogg, it ain't about Cam (It ain't about me)
I got a son homeboy, it's about Cam (For that?)
It's about being 'bout It
If you're not, you're ass backwards
My mathematics cause cash matters (That's important)
Little niggas need to sit up and breath
If the town's too hot, get up and leave
Niggas always got a trick up their sleeve (always)
Nigga like me - I always got a brick up my sleeve
And that's for-e-ver

[Verse 3]
Shit, I was two blocks from coppin dust
I used to hop the bus
Now look dogg, ain't nobody hot as us
Girls, they gotta rush
Shit, they gotta blush
Wanna go in the mall just to shop with us
To how they piss and bitch how they ran a mile
Fuck Killa Cam, they in love with Cameron Giles
Damn, I gotta smile
Hundred grand, I demand it
Cot damnit the boy the boy done done it child
And that's forever man

[Outro]
You hear it, uh huh
We here, I love y'all man
It's nothing boy
Dash, Hoffa, Young Guru
What's really good?
Holla at your boy
I might have this shit on lock man
Kanye, Harlem, Chicago, Columbus, Holla
Chicago, you have your own Kanye West on the track
Harlem, you know who the fuck I am - Killa!
We just want you's to know Diplomats is here
We ain't going nowhere
Holla atchya boy-boy, let's ride out man"

Song.create!(album_id: purple_haze.id, artist_id: camron.id, lyrics: lyrics_string,
title: "Dip-Set Forever", user_id: user_one.id)

lyrics_string =
"Killa
This that Harlem Music Right Here
This that Diddy Bop, Get ready for the winner music
That's what it is
Killa, Dip Set

[Cam'ron Verse]
Uh, Uh
You know me dawg, I just wanna keep the peace
But saying my name, that's only gonna lead to beef
Tell my niggas chill, but they wanna heat the streets (Be Easy)
Or do it on record, Check-we spit heat to beats

[Juelz Santana]
Everybody Welcoming this, Welcoming that
He wasn't welcome in the first place, how we welcome him back?

[Un Kasa]
Give me the Mac, let me welcome with that
Tell \"Mr. Rogers\", I leave his brains on the trolley track
Now prolly that

[Cam'ron Verse]
Listen, ya'll Stop It (Stop)
Know you appalled, got it
But this my call by the false prophet, all profit (all profit)
Harlem Hustler (yep), I can't at all knock it (nope)
But you hard, when you go in the Lord pockets
What you offering, put it right in offerin
They take it all, cash, credit, silver, down to porcelain
Look at the Porsche he's in (look at it)
Then Give them portioning (To Who?)
No handicap, Annie Rag, orphan friends
Friends, but the sizzurp I'm drinking on
Birds I'm thinking on
Get your Kirk Franklin on
Word, so you get your Ben Franklin on
Just when you think it's wrong
One blink, he's gone (damn)

[Hook]
Father Forgive us
We gon take him to church
Father Forgive us
And it's the truth it hurts
Father Forgive us
And that won't work
No, No, No, No, No Way

[Verse 2: Cam'ron]
Yo, you try to handle us
Get on the air and damage us
Screaming out Harlem (huh) like you ain't just abandoned us (Where you been at?)
Well let me fill you in, now it's a whole clan of us
Blink so mad, he went and beat up Canibus
Zeek got shot then Zeek locked up (then)
E got killed (what else?) B popped up but
B hopped up and still broke out his chest
On probation, Doe on house arrest (what up Doe)
Right out the flesh
Sit in a house and rest
He don't pout, get him gear, in the house he fresh (Fresssh)
Not that you care, just getting clear and think
One glare and wink
Everyone wearing pink
I'm the reason that your two rings are clear (Yeh, What Else?)
I'm the reason that your ear rings is square (Yeh, hear?)
Now we take trips to casinos, to lovely homes
You check on Lotti's mom, Minos, Honeycombs (Homes)
You trying to fake it with cardem, pardon
You gonna leave them naked like Tarzan

[Cam'ron Talking]
Kudo Love know that too

Holla at Kudo, ask Nelly about him

[Hook]

[Verse 3: Cam'ron]
Yo, Yo
I kill diamonds, get with pearls
I ain't trying kid the world
I ain't got beef, when I do, I say \"Get 'Em Girl\"
Not a diss dawg (nope) we just heard the fronting (Heard It)
Do Harlem a favor (What?) get a church or something (something)
A rec center in the winter where the youth can play
They don't even shoot the J
Sell drugs, shoot and spray
I'm knownbetter, still moving deuce a day
Two, that's two keys, I still move the Yay (Yayo)
Found a newer way
My crew do and say
Fist Fights to Shoot Outs, we won't move away

[Hook behind Cam'ron talking]

All my niggas that held it down the last half a decade
My nigga Gruff, Bad 140th, 139th
Black tone, White Tone, 142nd Rell Street
And 141st, Tito, My Jamaicans, My Belegians
33 33 Polo grounds, St.Nick colonial Jurist
Lincoln, Tab, Forster, Johnson, Jeff Wagner
Wilson, East River, The 9, 145th St.Nick, 145th Broadway
Lukas, Taliban, 135th, 118th, Manhattan
134th and 8th, Powerful what's really popping
Sarge hold your head, Freekey Zekey hold your head
The ol' B.B.O., 151st Amsterdam holla at your boy
A.K. Jackie Rob, All my niggas in Harlem
Get your hustle on
Keep your muscles strong
I know about the blocks you hustle on"

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

  Vote.create(user_id: upvoter.id, value: -1, votable_id: sunt_note_comment_two.id, votable_type: "Comment")
end

Album.first.songs.each_with_index do |song, i|
  upvoters.each_with_index do |upvoter, j|
    break if j >= i
    Vote.create(user_id: upvoter.id, value: 1, votable_id: song.id, votable_type: "Song")
  end
end

purple_haze.songs.each do |song|
  upvoters.each do |upvoter|
    v = Vote.new(user_id: upvoter.id, value: 1, votable_id: song.id, votable_type: "Song")
    v.created_at = 2.weeks.ago
    v.save
  end
end



guest_user = User.create(email: "guest@herokuapp.com", password: "password",
                        username: "guest")

