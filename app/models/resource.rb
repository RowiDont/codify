class Resource < ActiveRecord::Base
  validates_presence_of :link

  has_many(
    :category_tags,
    class_name: "CategoryResource",
    foreign_key: :resource_id,
    primary_key: :id
  )
  
  has_many :categories, through: :category_tags
end
