class CreateCategoriesCategories < ActiveRecord::Migration

  def up
    create_table :refinery_categories do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

    Refinery::Categories::Category.create_translation_table! :name => :string

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-categories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/categories/categories"})
    end

    drop_table :refinery_categories

    Refinery::Categories::Category.drop_translation_table!

  end

end
