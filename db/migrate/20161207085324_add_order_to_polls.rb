class AddOrderToPolls < ActiveRecord::Migration
  def change
    add_column(:refinery_polls, :order,:integer, default: 9999)
    add_index(:refinery_polls, :order)
  end
end
