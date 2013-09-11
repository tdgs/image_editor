module ImageEditor
  module CreateImageCommand
    extend self

    def run(opts)
      x = opts[:x].to_i
      y = opts[:y].to_i
      ImageEditor.image = ImageEditor::Image.new(x, y)
    end
  end
end
