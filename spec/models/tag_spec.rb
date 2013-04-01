require_relative '../spec_helper'

describe Tag do

  let(:tag) { Tag.new }

  it "should have proper attributes" do
    attributes  = [ :id, :name ]
    attributes.each{ |attribute| tag.should respond_to attribute }
  end

end