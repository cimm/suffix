# CountryFlagFilter
# Converts a 2-letter country code to a flag emoji.

module Jekyll
  module CountryFlagFilter
    def country_code_to_flag(input)
      return '' unless input && input.length == 2
      # Convert each letter to its regional indicator symbol equivalent
      input.upcase.codepoints.map{ |c| (c + 127_397).chr('UTF-8') }.join
    end
  end
end

Liquid::Template.register_filter(Jekyll::CountryFlagFilter)
