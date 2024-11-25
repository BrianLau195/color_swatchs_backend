class ColorsController < ApplicationController
  include ColorFormattable

  supports_format :rgb
  supports_format :hsl

  # When you with to include a new format in the future, you would just need to add the supports_format line for that format.
  # For example, if you added BRGB support:
  # supports_format :brgb
  # Make sure to add the format class to extend the Color::Base class.
  #
  # If you wish to remove a format, you would just need to remove the supports_format line for that format

  def index
    @colors = generate_random_colors
    render json: @colors
  end

  private

  def generate_random_colors(count: 5)
    Array.new(count) do
      format = supported_formats.sample
      generate_color_for_format(format)
    end.compact
  end

  def generate_color_for_format(format)
    color_class = "Color::#{format.camelize}".constantize
    {
      format: format,
      value: color_class.random
    }
  rescue NameError => e
    Rails.logger.error("Failed to generate color for format '#{format}': #{e.message}")
    nil
  end
end
