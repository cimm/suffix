namespace :db do

  desc "Drop and bootstrap the database with some demo data"
  task :demo => %w[environment db:drop db:create db:migrate db:seed] do
    # Locations
    number_of_locations = 10
    number_of_posts = 20
    max_number_of_comments = 10
    number_of_pages = 5
    number_of_locations.times{
      Location.create!(
        :label => Faker::Address.city,
        :latitude => rand * 100,
        :longitude => rand * 50
      )
    }
    Location.last.update_attribute(:current, true)
    # Posts
    number_of_posts.times{
      title = Faker::Lorem.sentence.chop
      post = Post.create!(
        :title => title,
        :permalink => CGI::escape(title.downcase),
        :location_id => rand(number_of_locations) + 1,
        :content => "<p>" + Faker::Lorem.paragraphs(rand(8)+1).join("</p><p>") + "</p>",
        :author => Faker::Name.name
      )
      # Comments
      rand(max_number_of_comments).times{
        post.comments.build(
          :content => Faker::Lorem.paragraphs.join(" "),
          :author => Faker::Name.name,
          :mail => Faker::Internet.email
        ).save!
      }
    }
    # Pages
    number_of_pages.times{
      title = Faker::Lorem.sentence.chop
      Page.create!(
        :title => title,
        :permalink => CGI::escape(title.downcase),
        :content => "<p>" + Faker::Lorem.paragraphs(rand(8)+1).join("</p><p>") + "</p>"
      )
    }
  end

end
