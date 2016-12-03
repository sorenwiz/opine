# This migration comes from refinery_polls (originally 1)
class CreatePollsPolls < ActiveRecord::Migration

  def up
    create_table :refinery_polls do |t|
      t.text :heading
      t.text :sub_heading
      t.text :teaser
      t.text :description_heading
      t.text :description
      t.datetime :expires_at
      t.string :slug
      t.integer :image_id
      t.integer :background_image_id
      t.integer :wallpaper_id
      t.integer :category_id
      t.text :question
      t.integer :position

      t.timestamps
    end

    Refinery::Polls::Poll.create_translation_table! :heading => :text, :sub_heading => :text, :teaser => :text, :description_heading => :text, :description => :text, :question => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-polls"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/polls/polls"})
    end

    drop_table :refinery_polls

    Refinery::Polls::Poll.drop_translation_table!

  end

end
