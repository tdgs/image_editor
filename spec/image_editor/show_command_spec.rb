require 'spec_helper'

describe ImageEditor::ShowCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "prints the image" do
    output = capture_stdout do
      ImageEditor::ShowCommand.run({})
    end

    output.should == image.to_s + "\n"
  end
end
