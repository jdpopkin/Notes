require "spec_helper"

describe User do

  # integration tests
  it "can check if a given password matches that of the user" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(user.is_password?("password")).to be_true
  end

  it "can find a user given their username and password" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(User.find_by_credentials("Test User", "password")).to be_true
  end
end
