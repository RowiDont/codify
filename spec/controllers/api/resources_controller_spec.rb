require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::ResourcesController, type: :controller do
  render_views

  before(:each) do
    User.create!(email: "rafiepatel@gmail.com")
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context "#index" do
    it "should render only the current user's resources" do
      user = User.first
      link1 = user.resources.create!(link: "user1link")
      link2 = Resource.create!(link: "fake.com/learn_fake")

      get :index, format: :json
      expect(assigns(:resources)).to include(link1)
      expect(assigns(:resources)).to_not include(link2)
    end
  end

  context "#show" do
    it "should render projects and categories linked to the resource" do
      user = User.first

      link = Resource.create!(link: "linked link")
      project = Project.create!(title: "a project!", user_id: user.id)
      category = Category.create!(name: "cool thing", user_id: user.id)

      CategoryResource.create!(category_id: category.id, resource_id: link.id)
      ProjectResource.create!(project_id: project.id, resource_id: link.id)

      get :show, id: link.id, format: :json
      expect(response.body).to have_node(:categories)
      expect(response.body).to have_node(:projects)
    end
  end

  context "#create" do
    it "should render relevant error messages for empty link" do
      get :create, resource: { "link" => "" }, format: :json

      expect(JSON.parse(response.body)["link"]).to eq(["can't be blank"])
      expect(response.status).to eq(422)
    end

    it "should render the show view on success" do
      get :create, resource: { "link" => "google.io" }, format: :json

      expect(JSON.parse(response.body)["link"]).to eq("google.io")
    end

    it "can create a project-resource tag on creation" do
      user = User.first
      project1 = Project.create!(title: "a project!", user_id: user.id)

      get :create, resource: { "link" => "google.io" }, project: { id: project1.id }, format: :json

      expect(JSON.parse(response.body)["projects"][0]["id"]).to eq(project1.id)
    end
  end
end
