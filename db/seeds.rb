#Reset auto increment - some rows are refering by id
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}") if table != "schema_migrations"
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Category.create! name: 'Politics'
Category.create! name: 'Nature'
Category.create! name: 'Society'

poll_image = Rails.root.join('app/assets/images/dummy_images/poll-image.jpg')
poll_bg = Rails.root.join('app/assets/images/dummy_images/poll-bg-image.jpg')

10.times do
  poll = Poll.create! heading: Faker::Lorem.sentence(5), sub_heading: Faker::Lorem.sentence(5),teaser: Faker::Lorem.sentence(40),
               description_heading: Faker::Lorem.sentence(5), description: Faker::Lorem.sentence(30), category_id: Category.all.sample(1).first.id,
               expires_at: rand(10..200).days.from_now, image: open(poll_image), background_image: open(poll_bg)
  rand(3..6).times do
    VoteOption.create! text: Faker::Lorem.sentence(3), poll: poll
  end
end
# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed
