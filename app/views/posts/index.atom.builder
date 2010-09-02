atom_feed('xmlns:georss' => 'http://www.georss.org/georss') do |feed|
  feed.title APP_CONFIG['title']
  feed.updated @last_update.to_time
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.content, :type => 'html')
      entry.georss :point do
        xml.text!("#{post.location.latitude} #{post.location.longitude}")
      end
      entry.author do |author|
        author.name(post.author)
      end
    end
  end
end
