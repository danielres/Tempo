require_relative '../spec_helper'
require_relative '../../models/tag'


describe Tag do

  let( :tag ) { Tag.new }

  describe '#new' do
    it "has proper attributes" do
      attributes  = %w( id name )
      attributes.each{ |attribute| tag.should respond_to attribute }
    end
  end

end