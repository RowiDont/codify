require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  render_views

  before(:each) do
    User.create!(email: "rafiepatel@gmail.com")
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context "#create" do
    it "should not allow blank email" do
      get :create, user: { "email" => "" }, format: :json

      expect(JSON.parse(response.body)["email"]).to include("can't be blank")
      expect(response.status).to eq(422)
    end

    it "should not allow invalid email" do
      get :create, user: { "email" => "rafi" }, format: :json

      expect(JSON.parse(response.body)["email"]).to include("is not an email")
      expect(response.status).to eq(422)
    end

    it "should not allow repeat email addresses" do
      get :create, user: { "email" => "rafiepatel@gmail.com" }, format: :json

      expect(JSON.parse(response.body)["email"]).to include("has already been taken")
      expect(response.status).to eq(422)
    end
  end

  context "#show" do
    it "should render basic user information" do
      user = User.first
      get :show, format: :json

      expect(JSON.parse(response.body)["id"]).to eq(user.id)
      expect(JSON.parse(response.body)["email"]).to eq(user.email)
    end

    it "should include user's categories and projects in arrays" do
      user = User.first
      redux = user.categories.create(name: "Redux")
      rails = user.categories.create(name: "Rails")
      project1 = Project.create!(title: "a project!", user_id: user.id)

      get :show, format: :json

      expect(response.body).to have_node(:categories)
      expect(JSON.parse(response.body)["categories"]).to be_an(Array)
      expect(response.body).to have_node(:projects)
      expect(JSON.parse(response.body)["projects"]).to be_an(Array)
    end
  end
end
