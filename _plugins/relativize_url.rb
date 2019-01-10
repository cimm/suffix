require 'pathname'

module Jekyll
  module UrlRelativizer
    def relativize_url(absolute_destination_path)
      source = Pathname.new(@context.registers[:page]['url'])
      destination = Pathname.new(absolute_destination_path)
      destination.relative_path_from(source).to_s
    end
  end
end

Liquid::Template.register_filter(Jekyll::UrlRelativizer)
