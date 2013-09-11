module ImageEditor
  module ClearImageCommand
    extend self

    def run(opts)
      ImageEditor.image.clear
    end
  end
end
