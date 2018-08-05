# RebrickableTag
# Liquid tag to fetch Lego sets metadata based on the set number.
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
# The following will return the image URL:
# {% rebrickable 6624 set_url %}

require 'uri'
require 'json'
require 'open-uri'

module Jekyll
  class RebrickableTag < Liquid::Tag
    CACHE_DIRNAME = '/tmp'.freeze
    CACHE_EXTENSION = '.json'.freeze
    CACHE_FILENAME_PREFIX = self.name.split('::').last.freeze
    REBRICKABLE_KEY = Jekyll.configuration({})['rebrickable_key'].freeze
    SETS_ENDPOINT_PREFIX = 'https://rebrickable.com/api/v3/lego/sets/'.freeze

    def render(context)
      @set_num = context[attrs.first]
      data = cached? ? read_cache : fetch_and_cache
      data[attrs.last]
    end

    private

    def attrs
      @markup.strip.split
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
      File.join(CACHE_DIRNAME, basename)
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
    end
  end
end

Liquid::Template.register_tag('rebrickable', Jekyll::RebrickableTag)
