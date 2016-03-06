require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) { User.create!(email: "rafiepatel@gmail.com") }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }


  it "should validate the name is unique" do
    user = User.first
    c1 = Category.create(name: "Hadoop", user_id: user)
    c2 = Category.create(name: "Hadoop", user_id: user)

    expect(c2.valid?).to eq(false)
  end

  it { should have_many(:resource_tags) }
  it { should have_many(:resources) }

  it { should have_many(:projects) }

  it "can access projects" do
    user = User.first
    c = user.categories.create!(name: "redux")
    pr = c.projects.create!(title: "Make america great again", user: user)

    expect(c.projects[0]).to eq(pr)
  end
end
