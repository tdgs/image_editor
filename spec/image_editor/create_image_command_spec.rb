require 'spec_helper'

describe ImageEditor::CreateImageCommand do

  before do
    ImageEditor.image = nil
  end

  it "creates the image" do
    image = ImageEditor::Image.new(3,1)
    ImageEditor::Image.should_receive(:new).with(3, 1).and_return(image)
    ImageEditor::CreateImageCommand.run(x: 3, y: 1)

    ImageEditor.image.should == image
  end
end
