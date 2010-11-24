Factory.define :location do |location|
  location.sequence(:label) { |n| "Label nr°#{n}" }
  location.latitude         { 51.4967 }
  location.longitude        { -0.111807 }
end

Factory.define :post do |post|
  post.sequence(:title)     { |n| "Post title nr°#{n}" }
  post.sequence(:permalink) { |n| "post-perma-#{n}" }
  post.association :location
end

Factory.define :page do |page|
  page.sequence(:title)     { |n| "Page title nr°#{n}" }
  page.sequence(:permalink) { |n| "page-perma-#{n}" }
end

Factory.define :tag do |tag|
  tag.sequence(:name) { |n| "Tag name nr°#{n}" }
  tag.posts { |posts| [posts.association(:post)] }
end

Factory.define :tagging do |tagging|
  tagging.association(:post) # { |posts| [posts.association(:post)] }
  tagging.association(:tag)
end
