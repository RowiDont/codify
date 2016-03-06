class Resource < ActiveRecord::Base
  validates_presence_of :link
  validates_uniqueness_of :link

  has_many(
    :category_tags,
    class_name: "CategoryResource",
    foreign_key: :resource_id,
    primary_key: :id
  )
  has_many :categories, through: :category_tags

  has_many(
    :user_tags,
    class_name: "ResourceUser",
    foreign_key: :resource_id,
    primary_key: :id
  )
  has_many :users, through: :user_tags

  has_many(
    :project_tags,
    class_name: "ProjectResource",
    foreign_key: :resource_id,
    primary_key: :id
  )
  has_many :projects, through: :project_tags
end
