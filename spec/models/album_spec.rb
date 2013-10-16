require "spec_helper"

describe Album do

  it "should return the overall score of an album" do
    album = Album.new(user_id: 1, artist_id: 1, title: "Test Album")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)

    album.stub(:votes).and_return([vote1, vote2, vote3])

    expect(album.score).to eq(3)
  end

  it "should return the overall score of an album when negative votes are present" do
    album = Album.new(user_id: 1, artist_id: 1, title: "Test Album")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(-1)
    vote3.stub(:value).and_return(-1)

    album.stub(:votes).and_return([vote1, vote2, vote3])

    expect(album.score).to eq(-1)
  end


  # integration tests
  it "should return the recent score of an album" do
    album = Album.create(user_id: 1, artist_id: 1, title: "Test Album")
    song1 = Song.create(user_id: 1, artist_id: 1, title: "Test Song",
            lyrics: "Words", album_id: album.id)

    song2 = Song.create(user_id: 1, artist_id: 1, title: "Test Song",
            lyrics: "Words", album_id: album.id)

    vote1 = Vote.create(user_id: 2, votable_id: song1.id, votable_type: "Song", value: 1)
    vote2 = Vote.create(user_id: 2, votable_id: song2.id, votable_type: "Song", value: 1)
    vote3 = Vote.create(user_id: 3, votable_id: song2.id, votable_type: "Song", value: 1)

    p album.songs
    p album.songs.last.votes
    p vote2
    p album.votes

    expect(album.recent_score).to eq(3)
  end


end