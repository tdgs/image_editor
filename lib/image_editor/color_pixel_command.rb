module ImageEditor
  module ColorPixelCommand
    extend self

    def run(opts)
      x = opts[:x].to_i
      y = opts[:y].to_i
      color = opts[:color]

      ImageEditor.image[x, y] = color
    end
  end
end
