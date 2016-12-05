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

end
# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Polls extension
Refinery::Polls::Engine.load_seed

# Added by Refinery CMS VoteOptions extension
Refinery::VoteOptions::Engine.load_seed
