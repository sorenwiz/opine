class AddQuestionToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :question, :string
  end
end
