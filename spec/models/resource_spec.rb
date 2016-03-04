require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { should validate_presence_of(:link) }
  it { should have_db_column(:description) }

  it { should have_many(:category_tags) }
  it { should have_many(:categories) }

  it { should have_many(:users) }

  it "will not allow repeat links" do
    l1 = Resource.create(link: "google.com")
    expect { Resource.create!(link: "google.com") }.to raise_exception
  end
end
