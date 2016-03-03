class User < ActiveRecord::Base
  validates :email, presence: true
  validate :is_email?

  def is_email?
    unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << "is not an email"
    end
  end
end
