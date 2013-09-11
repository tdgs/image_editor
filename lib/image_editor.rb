require "image_editor/version"
require 'image_editor/create_image_command'
require 'image_editor/clear_image_command'
require 'image_editor/color_pixel_command'
require 'image_editor/fill_region_command'
require 'image_editor/horizontal_draw_command'
require 'image_editor/vertical_draw_command'
require 'image_editor/show_command'
require "image_editor/terminate_command"
require "image_editor/router"
require "image_editor/image"

module ImageEditor

  class ImageNotInitializedError < StandardError; end
  class TerminateError < Exception; end
  class << self
    def image
      raise ImageNotInitializedError.new("You must initialize the image first. Try for example 'I 3 4'") if @image.nil?

      @image
    end

    def image=(image)
      @image = image
    end
  end
end
