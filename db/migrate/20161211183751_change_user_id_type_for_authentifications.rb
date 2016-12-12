class ChangeUserIdTypeForAuthentifications < ActiveRecord::Migration
  def up
    remove_column :authentications, :user_id
    add_column :authentications, :user_id, :integer
    add_index :authentications, :user_id
  end

  def down
    remove_column :authentications, :user_id
    add_column :authentications, :user_id, :string
  end
end
