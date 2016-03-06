class ProjectResource < ActiveRecord::Base
  self.table_name = "projects_resources"
  belongs_to :resource
  belongs_to :project
end
