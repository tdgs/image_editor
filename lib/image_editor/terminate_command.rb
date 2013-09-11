module ImageEditor
  module TerminateCommand
    extend self

    def run(opts)
      raise ImageEditor::TerminateError
    end
  end
end
