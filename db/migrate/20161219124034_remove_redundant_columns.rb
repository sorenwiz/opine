class RemoveRedundantColumns < ActiveRecord::Migration
  def up
    remove_column :refinery_poll_translations, :slug
    remove_column :refinery_polls, :position
    remove_column :refinery_vote_option_translations, :graph_rgb
  end

  def down
    puts 'Can`t restore`'
  end
end
