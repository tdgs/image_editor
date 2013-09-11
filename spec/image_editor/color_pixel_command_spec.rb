require 'spec_helper'

describe ImageEditor::ColorPixelCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "sets the pixel" do
    image.should_receive(:[]=).with(1, 1, "A")
    ImageEditor::ColorPixelCommand.run(x: "1", y: "1", color: "A")
  end
end
