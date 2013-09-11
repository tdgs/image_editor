require 'spec_helper'

describe ImageEditor::FillRegionCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "fills the region" do
    image.should_receive(:fill_region).with(1, 1, "A")
    ImageEditor::FillRegionCommand.run(x: "1", y: "1", color: "A")
  end
end
