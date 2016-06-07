class AddSlugToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :slug, :string
  end
end
