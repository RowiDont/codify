require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::CategoriesController, type: :controller do
  render_views

  before(:all) do
    DatabaseCleaner.clean

    user = User.create!(email: "rafiepatel@gmail.com")
    redux = user.categories.create(name: "Redux")
    rails = user.categories.create(name: "Rails")
    link1 = redux.resources.create(link: "google.com")

    #
    user2 = User.create!(email: "fake@it.com")
    flux = user2.categories.create(name: "flux")
    #
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  context "#index" do
    before(:each) { get :index, format: :json }

    it "should assign @categories of only the current user" do
      redux = Category.find_by_name("Redux")
      other = Category.find_by_name("flux")

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
    before(:each) do
      id = Category.find_by_name("Redux").id
      get :show, id: id, format: :json
    end

    it "should retrieve resources and projects for the category" do
      expect(response.body).to have_node(:resources)
      expect(response.body).to have_node(:projects)
    end

  end

end
