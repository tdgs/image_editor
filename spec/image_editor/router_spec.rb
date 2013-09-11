require 'spec_helper'

describe ImageEditor::Router do
  describe "I Command" do
    it "recognizes the command" do
      ImageEditor::CreateImageCommand.should_receive(:run).with(x: "32", y: "33")
      ImageEditor::Router.recognize("I 32 33")
    end

    it "requires fails with one argument" do
      expect {
        ImageEditor::Router.recognize("I 23")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "fails with non numerical arguments" do
      expect {
        ImageEditor::Router.recognize("I 2323 fail")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end
  end

  describe "L Command" do
    it "recognizes the command" do
      ImageEditor::ColorPixelCommand.should_receive(:run).with(x: "32", y: "33", color: "B")
      ImageEditor::Router.recognize("L 32 33 B   ")
    end

    it "requires fails with one argument" do
      expect {
        ImageEditor::Router.recognize("L 23 2323")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "fails with non numerical arguments" do
      expect {
        ImageEditor::Router.recognize("L 2323 fail")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "requires capital letter for color" do
      expect {
        ImageEditor::Router.recognize("L 2323 3232 d")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end
  end

  describe "V Command" do
    it "recognizes the command" do
      ImageEditor::VerticalDrawCommand.should_receive(:run).with(x: "32", y1: "33", y2: "35", color: "B")
      ImageEditor::Router.recognize("V 32 33 35 B   ")
    end

    it "requires fails with one argument" do
      expect {
        ImageEditor::Router.recognize("V 23 2323")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "fails with non numerical arguments" do
      expect {
        ImageEditor::Router.recognize("V 2323 fail")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "requires capital letter for color" do
      expect {
        ImageEditor::Router.recognize("V 2323 3232 d")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end
  end

  describe "H Command" do
    it "recognizes the command" do
      ImageEditor::HorizontalDrawCommand.should_receive(:run).with(x1: "32", x2: "33", y: "35", color: "B")
      ImageEditor::Router.recognize("H 32 33 35 B   ")
    end

    it "requires fails with one argument" do
      expect {
        ImageEditor::Router.recognize("H 23 2323")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "fails with non numerical arguments" do
      expect {
        ImageEditor::Router.recognize("H 2323 fail")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "requires capital letter for color" do
      expect {
        ImageEditor::Router.recognize("H 2323 3232 d")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end
  end

  describe "F Command" do
    it "recognizes the command" do
      ImageEditor::FillRegionCommand.should_receive(:run).with(x: "32", y: "33", color: "B")
      ImageEditor::Router.recognize("F 32 33 B   ")
    end

    it "requires fails with one argument" do
      expect {
        ImageEditor::Router.recognize("F 23 2323")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "fails with non numerical arguments" do
      expect {
        ImageEditor::Router.recognize("F 2323 fail")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end

    it "requires capital letter for color" do
      expect {
        ImageEditor::Router.recognize("F 2323 3232 d")
      }.to raise_error {
        ImageEditor::UnknownCommand
      }
    end
  end

  describe "C Command" do
    it "recognizes the command" do
      ImageEditor::ClearImageCommand.should_receive(:run).with({})
      ImageEditor::Router.recognize("C")
    end
  end

  describe "X Command" do
    it "recognizes the command" do
      ImageEditor::TerminateCommand.should_receive(:run).with({})
      ImageEditor::Router.recognize("X")
    end
  end

  describe "S Command" do
    it "recognizes the command" do
      ImageEditor::ShowCommand.should_receive(:run).with({})
      ImageEditor::Router.recognize("S")
    end
  end
end
