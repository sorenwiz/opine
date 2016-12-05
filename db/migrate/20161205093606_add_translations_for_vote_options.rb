class AddTranslationsForVoteOptions < ActiveRecord::Migration
  def change
    create_table(:refinery_vote_option_translations) do |t|
      t.text :text
      t.string :alias
      t.string :graph_rgb
      t.timestamps
    end
  end
end
