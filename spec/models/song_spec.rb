require "spec_helper"

describe Song do

  # note: break into describe and context blocks?

  it "should remove carriage returns in lyrics before validation" do
    lyrics_string = "First line\r\nSecond line\r\nThird line\r\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)
    song.valid?

    expect(song.lyrics).to eq(song.lyrics.gsub("\r", ""))
  end

  it "should return the overall song of a score" do
    lyrics_string = "First line\nSecond line\nThird line\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)

    song.stub(:votes).and_return([vote1, vote2, vote3])

    expect(song.score).to eq(3)
  end

  it "should return the overall song of a score when negative votes exist" do
    lyrics_string = "First line\nSecond line\nThird line\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(-1)
    vote3.stub(:value).and_return(-1)

    song.stub(:votes).and_return([vote1, vote2, vote3])

    expect(song.score).to eq(-1)
  end

  it "should return the recent score of a song" do
    lyrics_string = "First line\nSecond line\nThird line\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)
    vote1.stub(:created_at).and_return(1.hour.ago)
    vote2.stub(:created_at).and_return(1.hour.ago)
    vote3.stub(:created_at).and_return(1.hour.ago)

    song.stub(:votes).and_return([vote1, vote2, vote3])

    expect(song.recent_score).to eq(3)
  end

  it "should ignore votes more than 24 hours old in the #recent_score method" do
    lyrics_string = "First line\nSecond line\nThird line\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)
    vote1.stub(:created_at).and_return(1.week.ago)
    vote2.stub(:created_at).and_return(1.week.ago)
    vote3.stub(:created_at).and_return(1.hour.ago)

    song.stub(:votes).and_return([vote1, vote2, vote3])

    expect(song.recent_score).to eq(1)
  end

  it "should include score when converted to json" do
    lyrics_string = "First line\nSecond line\nThird line\n"
    song = Song.new(user_id: 1, album_id: 0, title: "Test Song",
      lyrics: lyrics_string)

    song.stub(:score).and_return(4)

    expect(song.as_json["score"]).to eq(4)
  end
end