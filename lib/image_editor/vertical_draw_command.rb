module ImageEditor
  module VerticalDrawCommand
    extend self

    def run(opts)
      x = opts[:x].to_i
      y1 = opts[:y1].to_i
      y2 = opts[:y2].to_i
      ImageEditor.image.draw_vertical(x, y1, y2, opts[:color])
    end
  end
end

