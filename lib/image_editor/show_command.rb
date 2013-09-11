module ImageEditor
  module ShowCommand
    extend self

    def run(opts)
      $stdout.write ImageEditor.image.to_s
    end
  end
end
