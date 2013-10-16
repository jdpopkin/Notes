require "spec_helper"

describe Vote do

  it "should not allow a user to vote on their own votable" do
    vote = Vote.new(votable_id: 1, votable_type: "Comment", user_id: 1, value: 1)

    comment1 = double("Comment")
    comment1.stub(:user_id).and_return(1)

    vote.stub(:votable).and_return(comment1)

    expect(vote).to_not be_valid
  end

  # should allow on others' votables
  it "should allow a user to vote on others' votables" do
    vote = Vote.new(votable_id: 1, votable_type: "Comment", user_id: 1, value: 1)

    comment1 = double("Comment")
    comment1.stub(:user_id).and_return(2)

    vote.stub(:votable).and_return(comment1)

    expect(vote).to be_valid
  end
end