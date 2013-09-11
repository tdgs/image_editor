module ImageEditor
  module HorizontalDrawCommand
    extend self

    def run(opts)
      x1 = opts[:x1].to_i
      x2 = opts[:x2].to_i
      y = opts[:y].to_i
      ImageEditor.image.draw_horizontal(x1, x2, y, opts[:color])
    end
  end
end

