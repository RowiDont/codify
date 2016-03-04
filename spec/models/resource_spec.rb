require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { should validate_presence_of(:link) }

  it { should have_many(:category_tags) }
  it { should have_many(:categories) }
end
