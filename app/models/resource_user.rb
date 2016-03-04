class ResourceUser < ActiveRecord::Base
  self.table_name = "resources_users"
  validates_presence_of :user_id, :resource_id
  belongs_to :user
  belongs_to :resource
end
