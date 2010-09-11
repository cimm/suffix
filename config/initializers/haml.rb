Haml.init_rails(binding) if defined?(Haml)
Haml::Template.options[:format] = :xhtml
Sass::Plugin.options[:style] = :compressed
