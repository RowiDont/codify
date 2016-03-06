require 'rails_helper'

RSpec.describe ProjectResource, type: :model do
  it { should belong_to(:project) }
  it { should belong_to(:resource) }
end
