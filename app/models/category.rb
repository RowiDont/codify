class Category < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user
  validates_uniqueness_of :name

  has_many(
    :resource_tags,
    class_name: "CategoryResource",
    foreign_key: :category_id,
    primary_key: :id
  )

  has_many :resources, through: :resource_tags

  has_many(
    :project_tags,
    class_name: "CategoryProject",
    foreign_key: :category_id,
    primary_key: :id
  )
  has_many :projects, through: :project_tags
end
