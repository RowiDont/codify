require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }

  it "should validate the name is unique" do
    user = User.new(email: "rafiepatel@gmail.com")

    c1 = Category.create(name: "Hadoop", user_id: user)
    c2 = Category.create(name: "Hadoop", user_id: user)

    expect(c2.valid?).to eq(false)
  end

  it { should have_many(:resource_tags) }
  it { should have_many(:resources) }
end
