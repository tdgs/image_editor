require 'spec_helper'

describe ImageEditor::Image do

  describe "initialize" do
    let(:image) {ImageEditor::Image.new(2, 3)}

    it "creates a new 2d table" do
      image.data.should == [["O","O"], ["O", "O"], ["O", "O"]]
    end

    it "raises an Error with a big size" do
      expect {
        ImageEditor::Image.new(259, 400)
      }.to raise_error(ImageEditor::ImageSizeBadError)
    end
  end

  describe "complete test" do
    it "acceps commands one after the other" do
      image = ImageEditor::Image.new(5, 6)
      image[2, 3] =  "A"
      image.data.should ==  [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "A", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]

      image.fill_region(3, 3, "J")
      image.draw_vertical(2, 3, 4, "W")
      image.draw_horizontal(3, 4, 2,"Z")

      image.data.should == [
        ["J", "J", "J", "J", "J"],
        ["J", "J", "Z", "Z", "J"],
        ["J", "W", "J", "J", "J"],
        ["J", "W", "J", "J", "J"],
        ["J", "J", "J", "J", "J"],
        ["J", "J", "J", "J", "J"],
      ]
    end
  end

  describe "to_s" do
    let(:image) {ImageEditor::Image.new(2, 3)}

    it "prints the table" do
      image.data = [
        ["J", "J", "J", "J", "J"],
        ["J", "J", "Z", "Z", "J"],
        ["J", "W", "J", "J", "J"],
        ["J", "W", "J", "J", "J"],
        ["J", "J", "J", "J", "J"],
        ["J", "J", "J", "J", "J"],
      ]


      expected = "J J J J J\n" +
                 "J J Z Z J\n" +
                 "J W J J J\n" +
                 "J W J J J\n" +
                 "J J J J J\n" +
                 "J J J J J"

      image.to_s.should == expected
    end
  end

  describe "data access" do
    let(:image) {ImageEditor::Image.new(5, 6)}

    it "can access by []" do
      image.data = [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "H", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]
      image[2, 3].should == "H"
    end

    it "saves with []=" do
      image[2, 3] = "H"
      image.data.should == [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "H", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]
    end

    it "raises OutofBoundsError with invalid Args" do
      expect {image[6,2]}.to raise_error {ImageEditor::OutOfBoundsError}
      expect {image[2,7]}.to raise_error {ImageEditor::OutOfBoundsError}
      expect {image[0,0]}.to raise_error {ImageEditor::OutOfBoundsError}
    end
  end

  describe "clear" do
    let(:image) {ImageEditor::Image.new(5, 6)}

    it "clears the image" do
      image.data = [
        ["O", "O", "O", "C", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "H", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "D", "O"],
        ["O", "O", "O", "O", "O"],
      ]

      image.clear

      image.data.should == [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]
    end
  end

  describe "draw_vertical" do
    let(:image) {ImageEditor::Image.new(5, 6)}
    let(:color) {"B"}
    let(:x) {3}
    let(:y1) {2}
    let(:y2) {5}

    it "raises ArgumentError if y2 > y1" do
      expect {
        image.draw_vertical(x, y2, y1, color)
      }.to raise_error { ArgumentError }
    end
    it "draws a vertical line with the color" do
      image.draw_vertical(x, y1, y2, color)

      image.data.should == [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "B", "O", "O"],
        ["O", "O", "B", "O", "O"],
        ["O", "O", "B", "O", "O"],
        ["O", "O", "B", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]
    end
  end

  describe "draw_horizontal" do
    let(:image) {ImageEditor::Image.new(5, 6)}
    let(:color) {"C"}
    let(:y) {3}
    let(:x1) {2}
    let(:x2) {4}

    it "raises ArgumentError if x2 > x1" do
      expect {
        image.draw_horizontal(x2, x1, y, color)
      }.to raise_error { ArgumentError }
    end

    it "draws a vertical line with the color" do
      image.draw_horizontal(x1, x2, y, color)

      image.data.should == [
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "C", "C", "C", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
        ["O", "O", "O", "O", "O"],
      ]
    end
  end

  describe "fill_region" do
    let(:image) {ImageEditor::Image.new(5, 6)}
    let(:color) {"C"}
    let(:y) {3}
    let(:x) {2}

    it "raises OutOfBoundsError" do
      expect {
        image.fill_region(7, 7, color)
      }.to raise_error { ImageEditor::OutOfBoundsError }
    end

    context "with an empty image" do
      it "paints the complete image with a color" do
        image.clear
        image.fill_region(3, 3, "J")

        image.data.should == [
          ["J", "J", "J", "J", "J"],
          ["J", "J", "J", "J", "J"],
          ["J", "J", "J", "J", "J"],
          ["J", "J", "J", "J", "J"],
          ["J", "J", "J", "J", "J"],
          ["J", "J", "J", "J", "J"],
        ]
      end
    end

    context "with non empty image" do
      it "respects the region" do
        image.data = [
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
        ]

        image.fill_region(3, 3, "J")

        image.data.should == [
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
        ]
      end

      it "respects the region with edge pixel" do
        image.data = [
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
        ]

        image.fill_region(5, 1, "J")

        image.data.should == [
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
          ["O", "A", "J", "J", "J"],
        ]
      end

      it "respects the region verticaly" do
        image.data = [
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
          ["O", "A", "O", "O", "O"],
        ]

        image.fill_region(2, 3, "J")

        image.data = [
          ["O", "J", "O", "O", "O"],
          ["O", "J", "O", "O", "O"],
          ["O", "J", "O", "O", "O"],
          ["O", "J", "O", "O", "O"],
          ["O", "J", "O", "O", "O"],
          ["O", "J", "O", "O", "O"],
        ]
      end
    end
  end


  describe "neighbours" do
    let(:image) {ImageEditor::Image.new(5, 6)}

    describe "with a pixel in the middle" do
      it "works" do
        image.neighbours(2, 3).should =~ [
          [1, 2], [2, 2], [3, 2],
          [1, 3],         [3, 3],
          [1, 4], [2, 4], [3, 4]
        ]
      end
    end

    describe "with a pixel in the final row" do
      it "works" do
        image.neighbours(2, 6).should =~ [
          [1, 5], [2, 5], [3, 5],
          [1, 6],         [3, 6],
        ]
      end
    end

    describe "with a pixel in the corner" do
      it "works" do
        image.neighbours(1, 1).should =~ [
          [1, 2],
          [2, 1],[2, 2],
        ]
      end
    end

    describe "with a pixel in the lower corner" do
      it "works" do
        image.neighbours(5, 6).should =~ [
          [4, 5], [4, 6],
          [5, 5],
        ]
      end
    end

    describe "with out of bounds pixel" do
      it "raises error" do
        expect {
          image.neighbours(7,7)
        }.to raise_error {ImageEditor::OutOfBoundsError}
      end
    end
  end
end
