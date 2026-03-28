module Jekyll
  class SkiMapTag < Liquid::Tag
    ASSET_DIR = 'assets/resorts'.freeze
    QGIS_SCRIPT = 'script:locationthumb'.freeze

    def initialize(tag_name, attrs, parse_context)
      super
      @attrs = attrs
      FileUtils.mkdir_p(ASSET_DIR) unless File.directory?(ASSET_DIR)
    end

    def render(context)
      resort = context[@attrs]
      @image_id = resort['openskimap_object']
      @lat, @lng = resort['coordinates']
      return unless @image_id
      generate unless cached?
      image_path
    end

    private

    def generate
      system('qgis_process',
             'run',
             QGIS_SCRIPT,
             "--CENTER_LAT=#{@lat}",
             "--CENTER_LNG=#{@lng}",
             "--OUT=#{image_path}")
    end

    def cached?
      File.file?(image_path)
    end

    def image_path
      filename = Pathname.new(@image_id).sub_ext('.png')
      File.join(ASSET_DIR, filename)
    end
  end
end

Liquid::Template.register_tag('ski_map', Jekyll::SkiMapTag)
