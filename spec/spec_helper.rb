require 'rubygems'
require 'bundler/setup'

require 'image_editor' # and any other gems you need

RSpec.configure do |c|
  c.filter_run_including focus: true
  c.run_all_when_everything_filtered = true

  c.before(:each) do
    ImageEditor.instance_variable_set(:@image, nil)
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
