require 'uri'
require 'open-uri'

module Jekyll
  class RebrickableTag < Liquid::Tag
    REBRICKABLE_KEY = Jekyll.configuration({})['rebrickable_key']
    SETS_ENDPOINT_PREFIX = 'https://rebrickable.com/api/v3/lego/sets/'

    def render(context)
      set_id = context[attrs.first]
      response = fetch(set_id)
      response[attrs.last]
    end

    private

    def fetch(set_id)
      set_id_with_suffix = "#{set_id}-1"
      uri = URI.join(SETS_ENDPOINT_PREFIX, set_id_with_suffix)
      buffer = uri.open('Accept' => 'application/json', 'Authorization' => "key #{REBRICKABLE_KEY}").read
      JSON.parse(buffer)
    end

    def attrs
      @markup.strip.split
    end
  end
end

Liquid::Template.register_tag('rebrickable', Jekyll::RebrickableTag)
