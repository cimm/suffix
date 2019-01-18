module Jekyll
  class RelativeBaseTag < Liquid::Tag
    def render(context)
      current_url = context.environments.first['page']['url']
      directories = current_url.split('/').reject do |i|
        i.empty? || i.casecmp('index.html').zero?
      end
      depth = directories.size
      depth.positive? ? Array.new(depth, '..').join('/') : '.'
    end
  end
end

Liquid::Template.register_tag('relbase', Jekyll::RelativeBaseTag)
