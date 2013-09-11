require 'spec_helper'

describe ImageEditor::ClearImageCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "clears the image" do
    image.should_receive(:clear)
    ImageEditor::ClearImageCommand.run({})
  end
end
