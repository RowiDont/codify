class CategoryProject < ActiveRecord::Base
  self.table_name = "categories_projects"
  belongs_to :project
  belongs_to :category
end
