require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe ProjectShare, type: :model do
  before(:each) { DatabaseCleaner.clean }
  after(:each) { DatabaseCleaner.clean }

  it { should belong_to(:user) }
  it { should belong_to(:project) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:project) }

  it "should check that user does not own the project" do
    user = User.create!(email: "rafiepatel@gmail.com")
    # user2 = User.create!(email: "rimon@gmail.com")
    # user3 = User.create!(email: "jo@shmo.net")
    project1 = Project.create!(title: "a project!", user_id: user.id)

    share = ProjectShare.create(project_id: project1.id, user_id: user.id)

    expect(share.errors.full_messages).to include("Project already belongs to you")
  end
end
