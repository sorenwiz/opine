#Reset auto increment - some rows are refering by id
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}") if table != "schema_migrations"
end

home_page = Refinery::Page.create!(
    title: "Home",
    deletable: false,
    link_url: "/",
    menu_match: "^/$"
)
home_page.parts.create(
    title: "Body",
    body: "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>",
    position: 0
)
home_page.parts.create(
    title: "Side Body",
    body: "<p>This is another block of content over here.</p>",
    position: 1
)

page_not_found_page = home_page.children.create(
    title: "Page not found",
    menu_match: "^/404$",
    show_in_menu: false,
    deletable: false
)
page_not_found_page.parts.create(
    title: "Body",
    body: '<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href="/">Return to the home page</a></p>',
    position: 0
)

Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang
  {'home' => 'Home',
   'page-not-found' => 'Page not found',
   'about' => 'About',
   'concept' => 'Concept'
  }.each do |slug, title|
    Refinery::Page.by_title(title).each do |page|
      page.update_attributes slug: slug
    end
  end
end

Category.create! name: 'Politics'
Category.create! name: 'Nature'
Category.create! name: 'Society'

category_id = Category.last.id

poll_image = Rails.root.join('app/assets/images/dummy_images/poll-image.jpg')
poll_bg = Rails.root.join('app/assets/images/dummy_images/poll-bg-image.jpg')

Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang
  5.times do |index|
    poll = Refinery::Polls::Poll.create do |post|
      post.heading = lang.to_s + ' Heading' + Faker::Lorem.sentence(1)
      post.sub_heading = lang.to_s + ' sub_heading' + Faker::Lorem.sentence(1)
      post.teaser = lang.to_s + ' teaser ' +  Faker::Lorem.sentence(1)
      post.description_heading = lang.to_s + ' description ' +  Faker::Lorem.sentence(1)
      post.description = lang.to_s +  Faker::Lorem.sentence(5)
      post.slug = index.to_s + 'poll_slug'
      post.question = lang.to_s +  Faker::Lorem.sentence(2)
      post.expires_at = Time.now + 10.days
      post.order = index
      post.category_id = category_id
      post.image = Refinery::Image.create(image: File.new(poll_image))
      post.background_image = Refinery::Image.create(image: File.new(poll_bg))
      post.wallpaper = Refinery::Image.create(image: File.new(poll_bg))
    end

    3.times do
      Refinery::VoteOptions::VoteOption.create do |vo|
        vo.text = Faker::Lorem.sentence(2)
        vo.alias = Faker::Lorem.sentence(1)
        vo.graph_rgb = '#9F3DE9'
        vo.poll_id = poll.id
      end
    end
  end
end

I18n.locale = ::Refinery::I18n.default_locale


