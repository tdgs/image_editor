require 'spec_helper'

describe ImageEditor do
  let(:image) {ImageEditor::Image.new(2, 3)}

  describe "getting the image" do
    context "with an image set" do
      before do
        ImageEditor.instance_variable_set(:@image, image)
      end

      it "returns the image" do
        ImageEditor.image.should == image
      end
    end

    context "without an image" do
      before do
        ImageEditor.instance_variable_set(:@image, nil)
      end

      it "raises error" do
        expect {
          ImageEditor.image
        }.to raise_error(ImageEditor::ImageNotInitializedError)
      end
    end
  end

  describe "setting the image" do
    it "sets the image" do
      ImageEditor.image = image

      ImageEditor.image.should == image
    end
  end
end
