require 'spec_helper'

describe ImageEditor::TerminateCommand do
  let(:image) {ImageEditor::Image.new(2,3)}

  before do
    ImageEditor.image = image
  end

  it "raises the TerminateError" do
    expect {
      ImageEditor::TerminateCommand.run({})
    }.to raise_error {ImageEditor::TerminateError}
  end
end
