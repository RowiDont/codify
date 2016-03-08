class ProjectShare < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: [:project_id] }
  validates_presence_of :user_id, :project_id
  validate :user_is_not_owner


  def user_is_not_owner
    if self.user_id == self.project.user_id
      errors[:project] = "already belongs to you"
    end
  end


end
