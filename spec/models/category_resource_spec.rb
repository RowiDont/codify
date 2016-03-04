require 'rails_helper'

RSpec.describe CategoryResource, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:resource) }
end
