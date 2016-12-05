class CreateVoteOptionsVoteOptions < ActiveRecord::Migration

  def up
    create_table :refinery_vote_options do |t|
      t.text :text
      t.text :alias
      t.text :graph_rgb
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-vote_options"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/vote_options/vote_options"})
    end

    drop_table :refinery_vote_options

  end

end
