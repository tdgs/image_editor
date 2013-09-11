require 'spec_helper'

describe ImageEditor::VerticalDrawCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "draws horizontaly" do
    image.should_receive(:draw_vertical).with(1, 2, 3, "A")
    ImageEditor::VerticalDrawCommand.run(x: "1", y1: "2", y2: "3", color: "A")
  end
end
