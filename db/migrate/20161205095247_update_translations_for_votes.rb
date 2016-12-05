class UpdateTranslationsForVotes < ActiveRecord::Migration
  def change
    add_column(:refinery_vote_option_translations, :refinery_vote_option_id, :integer)
    add_column(:refinery_vote_option_translations, :locale, :string, allow_null: false)
    add_index(:refinery_vote_option_translations, :refinery_vote_option_id, name: :votes_vote_option_idx)
    add_index(:refinery_vote_option_translations, :locale,  name: :votes_locales_idx)
  end
end
