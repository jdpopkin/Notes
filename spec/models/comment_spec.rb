require "spec_helper"

describe Comment do

  it "should return the overall score of a comment" do
    comment = Comment.new(user_id: 1, commentable_id: 1, commentable_type: "Song",
                          body: "Word")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(1)
    vote3.stub(:value).and_return(1)

    comment.stub(:votes).and_return([vote1, vote2, vote3])

    expect(comment.score).to eq(3)
  end

  it "should return the overall score of a comment when negative notes are present" do
    comment = Comment.new(user_id: 1, commentable_id: 1, commentable_type: "Song",
                          body: "Word")

    vote1 = double("Vote")
    vote2 = double("Vote")
    vote3 = double("Vote")

    vote1.stub(:value).and_return(1)
    vote2.stub(:value).and_return(-1)
    vote3.stub(:value).and_return(-1)

    comment.stub(:votes).and_return([vote1, vote2, vote3])

    expect(comment.score).to eq(-1)
  end

  it "should include score when converted to json" do
    comment = Comment.new(user_id: 1, commentable_id: 1, commentable_type: "Song",
                          body: "Word")

    comment.stub(:score).and_return(4)

    expect(comment.as_json["score"]).to eq(4)
  end

  it "should return #score when #cached_score is called" do
    comment = Comment.new(user_id: 1, commentable_id: 1,
                          commentable_type: "Song", body: "Word")

    comment.stub(:score).and_return(3)

    expect(comment.cached_score).to eq(3)


  end

  # integration tests
  it "should return the recent score of a comment" do
    comment = Comment.create(user_id: 1, commentable_id: 1,
                            commentable_type: "Song", body: "Word")

    vote1 = Vote.create(user_id: 2, votable_id: comment.id, votable_type: "Comment", value: 1)
    vote2 = Vote.create(user_id: 3, votable_id: comment.id, votable_type: "Comment", value: 1)
    vote3 = Vote.create(user_id: 4, votable_id: comment.id, votable_type: "Comment", value: 1)

    expect(comment.recent_score).to eq(3)
  end

  it "should only count recent votes toward #recent_score" do
    comment = Comment.create(user_id: 1, commentable_id: 1,
                            commentable_type: "Song", body: "Word")

    vote1 = Vote.create(user_id: 2, votable_id: comment.id, votable_type: "Comment", value: 1)
    vote2 = Vote.create(user_id: 3, votable_id: comment.id, votable_type: "Comment", value: 1)
    vote3 = Vote.create(user_id: 4, votable_id: comment.id, votable_type: "Comment", value: 1)

    vote1.created_at = 10.years.ago
    vote2.created_at = 10.years.ago

    vote1.save
    vote2.save

    expect(comment.recent_score).to eq(1)
  end


end
