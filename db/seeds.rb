#Reset auto increment - some rows are refering by id
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}") if table != "schema_migrations"
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
10.times do |i|
  poll = Poll.create! heading: Faker::Lorem.sentence(5), sub_heading: Faker::Lorem.sentence(5),teaser: Faker::Lorem.sentence(40),
               description_heading: Faker::Lorem.sentence(5), description: Faker::Lorem.sentence(30)
  rand(3..6).times do |i|
    VoteOption.create! text: Faker::Lorem.sentence(3), poll: poll
  end
end