module ColorFormattable
  extend ActiveSupport::Concern

  module ClassMethods
    def supports_format(format)
      format_name = format.to_s.downcase
      available_formats = Color::Base.descendants.map { |klass| klass.name.demodulize.downcase }

      unless available_formats.include?(format_name)
        raise ArgumentError, "Unsupported format '#{format_name}'. Available formats: #{available_formats.join(', ')}"
      end

      self.color_formats |= [ format_name ]
    end
  end

  included do
    class_attribute :color_formats, default: Set.new
  end

  def supported_formats
    self.class.color_formats.to_a
  end
end
