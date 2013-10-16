require "spec_helper"

describe Album do

  it "should return the overall score of a song" do
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


end