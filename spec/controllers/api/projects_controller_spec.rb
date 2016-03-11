require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::ProjectsController, type: :controller do
  render_views

  before(:each) do
    User.create!(email: "rafiepatel@gmail.com")
    User.create!(email: "rowi@gmail.com")
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context "#index" do
    it "should render the current user's projects" do
      user1 = User.first
      user2 = User.last
      r1 = user1.projects.create!(title: "user 1 project")
      r2 = user2.projects.create!(title: "user 2 project")

      get :index, format: :json

      expect(assigns(:projects)).to include(r1)
      expect(assigns(:projects)).to_not include(r2)

      expect(JSON.parse(response.body)).to include(
        {
         "id" => r1.id,
         "title" => r1.title,
         "description" => nil,
         "user_id" => user1.id
        }
      )
    end
  end

  context "#create" do
    it "should render errors on failed project creation" do
      post :create, project: { title: "" }, format: :json

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["title"]).to include("can't be blank")
    end

    it "should allow empty description" do
      post :create, project: { title: "hello", description: "" }, format: :json
      expect(response.status).to eq(200)
    end
  end

  context "#show" do
    it "should render resources (w/ category) linked to the project" do
      user = User.first

      project = Project.create!(title: "a project!", user_id: user.id)
      link1 = Resource.create!(link: "link1")
      link2 = Resource.create!(link: "link2")
      category = Category.create!(name: "cool thing", user_id: user.id)

      ProjectResource.create!(project_id: project.id, resource_id: link1.id)
      ProjectResource.create!(project_id: project.id, resource_id: link2.id)
      CategoryResource.create!(category_id: category.id, resource_id: link1.id)

      get :show, id: project.id, format: :json
      expect(response.body).to have_node(:resources)
      expect(
        JSON.parse(response.body)["resources"][0]["categories"][0]
      ).to eq({
        "id" => category.id,
        "name" => category.name
      })
    end

    it "should render an error if id does not exist" do
      get :show, id: 5, format: :json
      expect(JSON.parse(response.body)["errors"]).to include("does not exist")
      expect(response.status).to eq(404)
    end
  end

end
