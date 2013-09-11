module ImageEditor
  module FillRegionCommand
    extend self

    def run(opts)
      x = opts[:x].to_i
      y = opts[:y].to_i
      ImageEditor.image.fill_region(x, y, opts[:color])
    end
  end
end
