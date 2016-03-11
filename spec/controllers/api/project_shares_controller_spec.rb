require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Api::ProjectSharesController, type: :controller do
  render_views

  before(:each) do
    user = User.create!(email: "rafiepatel@gmail.com")
    user2 = User.create!(email: "rimon@gmail.com")
    project1 = Project.create!(title: "a project!", user_id: user.id)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context "#create" do
    it "should render errors when sharing own project with self" do
      user = User.find_by_email("rafiepatel@gmail.com")
      project = Project.first

      post :create, share: { "user_id" => user.id, "project_id" => project.id }, format: :json

      expect(JSON.parse(response.body)["project"]).to include("already belongs to you")
      expect(response.status).to eq(422)
    end

    it "should render errors when sharing with the same person twice" do
      user = User.find_by_email("rimon@gmail.com")
      project = Project.first
      ProjectShare.create!(user_id: user.id, project_id: project.id)

      post :create, share: { "user_id" => user.id, "project_id" => project.id }, format: :json

      expect(JSON.parse(response.body)["user_id"]).to include("has already been taken")
      expect(response.status).to eq(422)
    end

    it "should render errors when sharing with a nonexistent user or project" do
      user = User.last
      project = Project.last || { id: 1 }

      post :create, share: { "user_id" => user.id + 1, "project_id" => project[:id] + 1 }, format: :json

      expect(JSON.parse(response.body)["user"]).to include("can't be blank")
      expect(JSON.parse(response.body)["project"]).to include("can't be blank")
      expect(response.status).to eq(422)
    end

    it "should successfully link another user to the project" do
      user = User.find_by_email("rimon@gmail.com")
      project = Project.first
      post :create, share: { "user_id" => user.id, "project_id" => project.id }, format: :json

      expect(JSON.parse(response.body)["msg"]).to include("share successful")
      expect(response.status).to eq(200)
    end
  end

  context "#destroy" do
    it "should render errors if the current user does not own the project" do
      user1 = User.find_by_email("rafiepatel@gmail.com")
      user2 = User.find_by_email("rimon@gmail.com")
      project2 = user2.projects.create!(title: "the best project")
      share = ProjectShare.create!(user_id: user1.id, project_id: project2.id)

      delete :destroy, id: share.id, format: :json

      expect(JSON.parse(response.body)["msg"]).to include("not your project")
    end

    it "should render errors if their was no project share with that id" do
      user1 = User.find_by_email("rafiepatel@gmail.com")
      user2 = User.find_by_email("rimon@gmail.com")
      last_id = ProjectShare.last || { id: 1 }

      delete :destroy, id: last_id[:id] + 1, format: :json

      expect(JSON.parse(response.body)["msg"]).to include("does not exist")
    end

    it "should delete project share" do
      user = User.find_by_email("rimon@gmail.com")
      project = Project.first
      share = ProjectShare.create!(user_id: user.id, project_id: project.id)

      delete :destroy, id: share.id, format: :json

      expect(ProjectShare.all).to eq([])
    end

  end
end
