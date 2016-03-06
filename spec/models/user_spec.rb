require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
  before(:each) { DatabaseCleaner.clean }
  after(:each) { DatabaseCleaner.clean }

  it { should allow_value('rafiepatel@gmail.com').for(:email) }
  it { should_not allow_value('rafi').for(:email) }
  it { should validate_presence_of(:email) }
  it "should validate uniqueness of email" do
    u1 = User.create!(email: "originalDude@netscape.net")

    expect { User.create!(email: "originalDude@netscape.net") }.to raise_exception
  end

  it { should have_many(:categories) }
  it { should have_many(:projects) }

  it { should have_many(:resources) }

  it "can access resources" do
    u = User.create(email: "email@mail.com")
    r = u.resources.create(link: "google.com/help")

    expect(u.resources[0].id).to eq(r.id)
  end
end
