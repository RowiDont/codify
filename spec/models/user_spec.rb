require 'rails_helper'

RSpec.describe User, type: :model do
  it { should allow_value('rafiepatel@gmail.com').for(:email) }
  it { should_not allow_value('rafi').for(:email) }
  it { should validate_presence_of(:email) }

  it { should have_many(:categories) }
  it { should have_many(:projects) }

  it { should have_many(:resources) }

  it "can access resources" do
    u = User.create(email: "email@mail.com")
    r = u.resources.create(link: "google.com/help")

    expect(u.resources[0].id).to eq(r.id)
  end
end
