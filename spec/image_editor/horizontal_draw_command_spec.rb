require 'spec_helper'

describe ImageEditor::HorizontalDrawCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "draws horizontaly" do
    image.should_receive(:draw_horizontal).with(1, 2, 3, "A")
    ImageEditor::HorizontalDrawCommand.run(x1: "1", x2: "2", y: "3", color: "A")
  end
end
