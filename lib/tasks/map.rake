namespace :map do

  # Leuven 50.851249142738, 4.454956054687

  desc "Updates the /images/map.png with a new OpenStreetMap for the current Dopplr location with a fallback to the last post location"
  task :dopplr_trip_or_last_post => :environment do
    Rake::Task["map:last_post"].invoke
    Rake::Task["map:current_dopplr_trip"].invoke # will overwrite previous if found
  end

  desc "Updates the /images/map.png with a new OpenStreetMap for a given latitude and longitude"
  task :location => :environment do
    unless ENV.include?("lat") &&  ENV.include?("long")
      raise "Usage: rake map:location lat=LATITUDE long=LONGITUDE"
    end
    create_map(ENV['lat'], ENV['long'], 1200, 100, 0.3, 8)
  end

  desc "Updates the /images/map.png with a new OpenStreetMap for my current Dopplr trip, if found"
  task :current_dopplr_trip => :environment do
    unless APP_CONFIG['dopplr']['future_trips']
      raise "Missing future_trips key in the application config!"
    end
    require "open-uri"
    doc = Nokogiri::XML(open(APP_CONFIG['dopplr']['future_trips']))
    doc.xpath("/xmlns:feed/xmlns:entry").each do |entry|
      entry_times = entry.xpath("gd:when") # slightly better performance as 2 xpath queries
      start_date = entry_times.first.attributes["startTime"].to_s.to_date
      end_date = entry_times.first.attributes["endTime"].to_s.to_date
      if start_date <= Date.today && end_date >= Date.today
        latitude, longitude = entry.xpath("georss:where/gml:Point/gml:pos").text.split(' ')
        create_map(latitude, longitude, 1200, 100, 0.3, 8)
        break
      end
    end
  end

  desc "Updates the /images/map.png with a new OpenStreetMap for the current location in the database (locations table)"
  task :current_location => :environment do
    unless current_location = Location.current
      raise "No current location found in the database!"
    end
    create_map(current_location.latitude, current_location.longitude, 1200, 100, 0.3, 8)
  end

  desc "Updates the /images/map.png with a new OpenStreetMap for the location of the most reccent blog post"
  task :last_post => :environment do
    unless last_post = Post.last
      raise "No blog posts found in the database!"
    end
    create_map(last_post.location.latitude, last_post.location.longitude, 1200, 100, 0.3, 8)
  end

  private

  def create_map(latitude, longitude, width = 500, height = 500, opacity = 1, zoom = 7)
    require 'open-uri'
    require 'RMagick'
    include Magick
    url = URI.parse("http://ojw.dev.openstreetmap.org/StaticMap/?lat=#{latitude}&lon=#{longitude}&z=#{zoom}&w=#{width}&h=#{height}&att=none&show=1")
    mask = Image.read("#{Rails.root}/public/images/map_mask.png")[0]
    overlay = Image.new(width, height) { self.background_color = '#efefef' }
    map = ImageList.new
    map.from_blob(url.read) # get a map image form OpenStreetMap
    map = map.quantize(256, GRAYColorspace)
    composite = map.dissolve(overlay, 0.5, opacity)
    composite = composite.composite(mask, EastGravity, OverCompositeOp) # add the gradient on the right side
    composite.minify
    composite.write("#{Rails.root}/public/images/map.png")
  end

end
