require 'rails_helper'

RSpec.describe User, type: :model do
  it { should allow_value('rafiepatel@gmail.com').for(:email) }
  it { should_not allow_value('rafi').for(:email) }
  it { should validate_presence_of(:email) }
end
