require 'rails_helper'

RSpec.describe CategoryProject, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:project) }
end
