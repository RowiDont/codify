class Project < ActiveRecord::Base
  validates_presence_of :title, :user_id

  belongs_to :user

  has_many(
    :category_tags,
    class_name: "CategoryProject",
    foreign_key: :project_id,
    primary_key: :id
  )
  has_many :categories, through: :category_tags
end
