class ConvertExpiresAtToDate < ActiveRecord::Migration
  def change
    change_column :polls, :expires_at, :date
  end
end
