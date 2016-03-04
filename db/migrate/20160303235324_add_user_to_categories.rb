class AddUserToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :string, null: false
  end
end
