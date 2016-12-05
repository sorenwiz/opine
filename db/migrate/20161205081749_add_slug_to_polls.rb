class AddSlugToPolls < ActiveRecord::Migration
  def change
    add_column(:refinery_poll_translations, :slug, :text)
  end
end
