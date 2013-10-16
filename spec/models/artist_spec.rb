require "spec_helper"

describe Artist do

  it "should return the overall score of an artist" do
    artist = Artist.new(user_id: 1, name: "Test Artist")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)

    artist.stub(:votes).and_return([vote1, vote2, vote3])

    expect(artist.score).to eq(3)
  end

  it "should return the overall score of an artist when negative votes are present" do
    artist = Artist.new(user_id: 1, name: "Test Artist")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(-1)
    vote3.stub(:value).and_return(-1)

    artist.stub(:votes).and_return([vote1, vote2, vote3])

    expect(artist.score).to eq(-1)
  end

  # integration tests
  it "should return the recent score of an artist" do
    artist = Artist.create(user_id: 1, name: "Test Artist")
    song1 = Song.create(user_id: 1, artist_id: artist.id, title: "Test Song",
            lyrics: "Words")

    song2 = Song.create(user_id: 1, title: "Test Song", lyrics: "Words",
            artist_id: artist.id)

    vote1 = Vote.create(user_id: 2, votable_id: song1.id, votable_type: "Song", value: 1)
    vote2 = Vote.create(user_id: 2, votable_id: song2.id, votable_type: "Song", value: 1)
    vote3 = Vote.create(user_id: 3, votable_id: song2.id, votable_type: "Song", value: 1)

    expect(artist.recent_score).to eq(3)
  end

  it "should only count recent votes toward recent_score" do
    artist = Artist.create(user_id: 1, name: "Test Artist")
    song1 = Song.create(user_id: 1, title: "Test Song", lyrics: "Words",
                        artist_id: artist.id)

    song2 = Song.create(user_id: 1, title: "Test Song", lyrics: "Words",
                        artist_id: artist.id)

    vote1 = Vote.create(user_id: 2, votable_id: song1.id, votable_type: "Song", value: 1)
    vote2 = Vote.create(user_id: 2, votable_id: song2.id, votable_type: "Song", value: 1)
    vote3 = Vote.create(user_id: 3, votable_id: song2.id, votable_type: "Song", value: 1)

    p [vote1, vote2, vote3]

    vote1.created_at = 1.year.ago
    vote2.created_at = 1.year.ago

    vote1.save
    vote2.save

    expect(artist.recent_score).to eq(1)
  end

  it "should return #score when #cached_score is called" do
    artist = Artist.create(user_id: 1, name: "Test Artist")

    artist.stub(:recent_score).and_return(3)

    expect(artist.cached_score).to eq(3)
  end


end