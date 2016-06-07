class CreateVoteOptions < ActiveRecord::Migration
  def change
    create_table :vote_options do |t|
      t.string :text
      t.integer :poll_id

      t.timestamps null: false
    end
  end
end
