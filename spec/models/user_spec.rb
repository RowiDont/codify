require 'rails_helper'

RSpec.describe User, type: :model do

  it "will not accept 'invalid' emails" do
    user = User.create({email: "rafi"})
    expect(User.all).to be_empty
  end

  it "will accept 'valid' emails" do
    user = User.create!({email: "rafiepatel@gmail.com"})
    expect(User.all.length).to eq(1)
  end
end
