class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :poll_id
      t.integer :user_id
      t.integer :vote_option_id

      t.timestamps null: false
    end
  end
end
