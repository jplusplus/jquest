require 'rails_helper'

RSpec.describe User, type: :model do
  it "has one after adding one" do
    User.create email: 'enroll@jquestapp.com'
    expect(User.count).to eq 1
  end

  it "has one with the same email" do
    User.create email: 'contact@jplusplus.org'
    User.create email: 'contact@jplusplus.org'
    expect(User.count).to eq 1
  end

  it "has one with the same email and being case sensitive" do
    User.create email: 'contact@jplusplus.org'
    User.create email: 'CONTACT@jplusplus.org'
    expect(User.count).to eq 1
  end

  it "saves email in lowercase" do
    User.create email: 'CONTACT@jplusplus.org'
    expect(User.first.email).to eq 'contact@jplusplus.org'
  end

  it "has md5 email" do
    User.create email: 'contact@jplusplus.org'
    expect(User.first.email_md5).to eq '0a836ee9e71fb926c2c2cf649b7b6047'
  end

  it "still has one after adding one" do
    User.create email: 'contact@jplusplus.org'
    expect(User.count).to eq 1
  end

  it "has one with no activities" do
    User.create email: 'enroll@jquestapp.com'
    expect(User.first.activities.count).to eq 0
  end

  it "has one with no assignments" do
    User.create email: 'enroll@jquestapp.com'
    expect(User.first.assignments.count).to eq 0
  end

  it "should be inactive" do
    User.create email: 'enroll@jquestapp.com'
    expect(User.first.status).to be :inactive
  end

  it "should be invited" do
    user = User.create email: 'enroll@jquestapp.com'
    user.invite!
    expect(User.first.status).to be :invited
  end
end
