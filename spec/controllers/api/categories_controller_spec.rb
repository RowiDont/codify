require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::CategoriesController, type: :controller do
  render_views

  before(:each) do
    user = User.create!(email: "rafiepatel@gmail.com")
    redux = user.categories.create(name: "Redux")
    rails = user.categories.create(name: "Rails")
    link1 = redux.resources.create(link: "google.com")

    #
    user2 = User.create!(email: "fake@it.com")
    flux = user2.categories.create(name: "Flux")
    #
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context "#index" do
    before(:each) { get :index, format: :json }

    it "should assign @categories of only the current user" do
      redux = Category.find_by_name("Redux")
      other = Category.find_by_name("Flux")

      expect(assigns(:categories)).to_not include(other)
      expect(assigns(:categories)).to include(redux)
    end

    it "should render an array of items" do
      expect(JSON.parse(response.body)).to be_an(Array)
    end

    it "should render id and name for each category" do
      expect(response.body).to have_node(:id)
      expect(response.body).to have_node(:name)
    end
  end

  context "#show" do
    it "should retrieve resources and projects for the category" do
      id = Category.find_by_name("Redux").id
      get :show, id: id, format: :json

      expect(response.body).to have_node(:resources)
      expect(response.body).to have_node(:projects)
    end

    it "should render an error if id does not exist" do
      get :show, id: 5, format: :json
      expect(JSON.parse(response.body)["errors"]).to include("does not exist")
      expect(response.status).to eq(404)
    end
  end

  context "#create" do
    it "should respond with an error on missing name" do
      get :create, category: { "name" => "" }, format: :json

      expect(JSON.parse(response.body)["name"]).to eq(["can't be blank"])
      expect(response.status).to eq(422)
    end

    it "should render the show view on success" do
      get :create, category: { "name" => "React" }, format: :json

      expect(JSON.parse(response.body)["name"]).to eq("React")
    end
  end

end
