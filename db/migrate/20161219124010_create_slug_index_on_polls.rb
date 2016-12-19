class CreateSlugIndexOnPolls < ActiveRecord::Migration
  def change
    add_index :refinery_polls, :slug
  end
end
