require "spec_helper"

describe Note do

  it "should return the overall score of a note" do
    note = Note.new(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)

    note.stub(:votes).and_return([vote1, vote2, vote3])

    expect(note.score).to eq(3)
  end

  it "should return the overall score of a comment when negative notes are present" do
    note = Note.new(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(-1)
    vote3.stub(:value).and_return(-1)

    note.stub(:votes).and_return([vote1, vote2, vote3])

    expect(note.score).to eq(-1)

  end

  it "should include score when converted to json" do
    note = Note.new(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    note.stub(:score).and_return(4)

    expect(note.as_json["score"]).to eq(4)
  end

  it "should return #score when #cached_score is called" do
    note = Note.new(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    note.stub(:score).and_return(3)

    expect(note.cached_score).to eq(3)
  end

  # recent_score
  it "should return the recent score of a note" do
    note = Note.create(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    vote1 = Vote.create(user_id: 2, votable_id: note.id, votable_type: "Note", value: 1)
    vote2 = Vote.create(user_id: 3, votable_id: note.id, votable_type: "Note", value: 1)
    vote3 = Vote.create(user_id: 4, votable_id: note.id, votable_type: "Note", value: 1)

    expect(note.recent_score).to eq(3)
  end

  it "should only count recent votes towards #recent_score" do
    note = Note.create(author_id: 1, song_id: 1, start_index: 10, end_index: 20,
                    body: "Word")

    vote1 = Vote.create(user_id: 2, votable_id: note.id, votable_type: "Note", value: 1)
    vote2 = Vote.create(user_id: 3, votable_id: note.id, votable_type: "Note", value: 1)
    vote3 = Vote.create(user_id: 4, votable_id: note.id, votable_type: "Note", value: 1)

    vote1.created_at = 10.minutes.ago
    vote2.created_at = 10.years.ago
    vote3.created_at = 10.years.ago

    vote1.save
    vote2.save
    vote3.save

    expect(note.recent_score).to eq(1)
  end

end
