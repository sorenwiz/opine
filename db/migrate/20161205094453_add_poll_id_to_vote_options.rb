class AddPollIdToVoteOptions < ActiveRecord::Migration
  def change
    add_column(:refinery_vote_options, :poll_id, :integer)
    add_index(:refinery_vote_options, :poll_id)
  end
end
