class CategoryResource < ActiveRecord::Base
  self.table_name = "categories_resources"

  belongs_to :category
  belongs_to :resource
end
