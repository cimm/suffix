class PhotosController < ApplicationController

  def index
    unless read_fragment(:latest)
      doc = Nokogiri::XML(open(APP_CONFIG['flickr']['feed']))
      @photos = doc.xpath("//rss/channel/item").each_with_object([]) { |item, photos|
        title = item.xpath("title").text
        link = item.xpath("link").text
        thumb = item.xpath("media:thumbnail/@url").text
        photos << { :title => title, :link => link, :thumb => thumb }
      }
    end
  end

end
