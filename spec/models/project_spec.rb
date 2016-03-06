require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Project, type: :model do
  before(:each) { DatabaseCleaner.clean }
  after(:each) { DatabaseCleaner.clean }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }

  it { should have_many(:resources) }

  it { should have_many(:categories) }
  it "can access categories" do
    user = User.create!(email: "example@ex.com")
    pr = user.projects.create!(title: "Make america great again")
    c = pr.categories.create!(name: "redux", user_id: user.id)

    expect(pr.categories[0]).to eq(c)
  end
end
