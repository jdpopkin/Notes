require "spec_helper"

describe User do

  # integration tests
  it "can check if a given password matches that of the user" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(user.is_password?("password")).to be_true
  end

  it "will return false when the password does not match" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(user.is_password?("wrong_password")).to be_false
  end

  it "can find a user given their username and password" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(User.find_by_credentials("Test User", "password")).to be
  end

  it "will not return a user if password is incorrect" do
    user = User.create(email: "asdf@asdf.com", password: "password",
                      username: "Test User")

    expect(User.find_by_credentials("Test User", "wrong_password")).to be_nil
  end
end
