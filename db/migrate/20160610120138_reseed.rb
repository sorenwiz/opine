class Reseed < ActiveRecord::Migration
  def change
    require Rails.root.join 'db/seeds.rb'
  end
end
