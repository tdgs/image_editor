module ImageEditor
  class UnknownCommand < StandardError; end

  module Router
    extend self

    TABLE = [
      [/^I\s+(?<x>\d+)\s+(?<y>\d+)\s*$/, CreateImageCommand],
      [/^L\s+(?<x>\d+)\s+(?<y>\d+)\s+(?<color>[A-Z])\s*$/, ColorPixelCommand],
      [/^V\s+(?<x>\d+)\s+(?<y1>\d+)\s+(?<y2>\d+)\s+(?<color>[A-Z])\s*$/, VerticalDrawCommand],
      [/^H\s+(?<x1>\d+)\s+(?<x2>\d+)\s+(?<y>\d+)\s+(?<color>[A-Z])\s*$/, HorizontalDrawCommand],
      [/^F\s+(?<x>\d+)\s+(?<y>\d+)\s+(?<color>[A-Z])\s*$/, FillRegionCommand],
      [/C/, ClearImageCommand],
      [/X/, TerminateCommand],
      [/S/, ShowCommand]
    ]

    def recognize(string)
      match_data = nil
      result = TABLE.find do |(pattern, _)|
        match_data = string.match pattern
      end

      raise ImageEditor::UnknownCommand.new(string) if result.nil?

      run_command(result[1], match_data)
    end

    def run_command(command, match_data)
      opts = Hash[match_data.names.map(&:to_sym).zip(match_data.captures)]

      command.run(opts)
    end
  end
end
