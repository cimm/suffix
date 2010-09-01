class UrlFormatValidator < ActiveModel::EachValidator

  WEBSITE_REGEXP = %r{\Ahttps?://[-\w.]*\w+\.[A-Za-z]{2,}.+\z}

  def validate_each record, attribute, value
    # By default allow blank, pass false to ensure presence
    allow_blank = options[:allow_blank] || true
    if value.present? # allow blank
      unless value.start_with? "http" # add http:// if no protocol given
        value = "http://#{value}"
        record.send "#{attribute}=", value
      end
      unless value =~ WEBSITE_REGEXP
        record.errors.add attribute, "wrong format", options
      end
    elsif !allow_blank
      record.errors.add attribute, :blank, options
    end
  end

end
