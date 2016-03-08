class User < ActiveRecord::Base
  def self.rails_env
    Rails.env == "production" ? "pro" : "dev"
  end

  def self.random_avatar
    rand(12) + 1
  end

  has_attached_file :avatar,
                    styles: {
                      large: "600x600",
                      medium: "300x300>",
                      thumb: "100x100>"
                    },
                    default_url: "https://s3.amazonaws.com/codify-#{User.rails_env}/default-avatars/retro-seamless-patterns-#{User.random_avatar}.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :email, presence: true
  validates_uniqueness_of :email
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
