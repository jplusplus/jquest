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
end
