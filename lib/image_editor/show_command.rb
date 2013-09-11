module ImageEditor
  module ShowCommand
    extend self

    def run(opts)
      $stdout.write ImageEditor.image.to_s
      $stdout.write "\n"
    end
  end
end
