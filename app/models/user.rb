class User < ActiveRecord::Base
  validates :email, presence: true
  validate :is_email?

  has_many :projects
  has_many :categories

  has_many(
    :resource_tags,
    class_name: "ResourceUser",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many :resources, through: :resource_tags

  def is_email?
    unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << "is not an email"
    end
  end
end
