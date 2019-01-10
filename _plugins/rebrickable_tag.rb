# RebrickableTag
# Liquid tag to fetch Lego sets metadata based on the set number.
# It will also download the Lego set images to the ASSET_DIR so
# the generated site does not hot load them from Rebrickable.
#
# Add a `rebrickable_key` entry to the _config.yaml with your
# Rebrickable API key, next use the the tag in the views:
#
# {% rebrickable set_num set_attribute %}
# set_num
#   the Lego set number, e.g., 6624
# set_attribute
#   the wanted attribute: set_num,
#                         name,
#                         year,
#                         theme_id,
#                         num_parts,
#                         set_img_url,
#                         set_url,
#                         last_modified_dt
#
# The following will return the number of parts:
# {% rebrickable 6624 num_parts %}
#
# while this returns a path to the locally downloaded image:
# {% rebrickable 6624 set_img_url %}

require 'uri'
require 'json'
require 'open-uri'
require 'tmpdir'

module Jekyll
  class RebrickableTag < Liquid::Tag
    CACHE_EXTENSION = '.json'.freeze
    CACHE_FILENAME_PREFIX = self.name.split('::').last.freeze
    REBRICKABLE_KEY = Jekyll.configuration({})['rebrickable_key'].freeze
    SETS_ENDPOINT_PREFIX = 'https://rebrickable.com/api/v3/lego/sets/'.freeze
    ASSET_DIR = 'assets/lego'.freeze

    def render(context)
      @set_num = context[attrs.first]
      data = cached? ? read_cache : fetch_and_cache
      rendered = data[attrs.last]
      rendered = download_image(data['set_img_url']) if set_img_url?
      rendered
    end

    private

    # Download set image from Rebrickable to local asset directory
    def download_image(url)
      FileUtils.mkdir_p(ASSET_DIR) unless File.directory?(ASSET_DIR)
      filename = URI(url).path.split('/').last
      path = File.join(ASSET_DIR, filename)
      return path if File.exists?(path)
      io = open(url)
      FileUtils.mv(io.path, path)
      FileUtils.chmod(0644, path)
      path
    end

    def attrs
      @markup.strip.split
    end

    def set_img_url?
      attrs.last.downcase == 'set_img_url'
    end

    def write_cache(data)
      pretty_data = JSON.pretty_generate(data)
      File.open(cache_path, 'w') do |f|
        f.write(pretty_data)
      end
    end

    def read_cache
      data = File.read(cache_path)
      JSON.parse(data)
    end

    def cached?
      File.file?(cache_path)
    end

    def cache_path
      basename = [CACHE_FILENAME_PREFIX, @set_num, CACHE_EXTENSION].join
      File.join(Dir.tmpdir, basename)
    end

    def fetch_and_cache
      data = fetch
      write_cache(data)
      data
    end

    def fetch
      set_num_with_suffix = "#{@set_num}-1"
      uri = URI.join(SETS_ENDPOINT_PREFIX, set_num_with_suffix)
      response = uri.open('Accept' => 'application/json', 'Authorization' => "key #{REBRICKABLE_KEY}").read
      JSON.parse(response)
    rescue OpenURI::HTTPError => error
      raise 'Rebrickable auth error, check your API key' if error.io.status.first == '401'
    end
  end
end

Liquid::Template.register_tag('rebrickable', Jekyll::RebrickableTag)
