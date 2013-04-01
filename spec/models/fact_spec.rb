require_relative '../spec_helper'

describe Fact do

  let(:fact) { Fact.new }

  it "has proper attributes" do
    attributes  = [ :id, :start_time, :end_time, :description ]
    attributes.each{ |attribute| fact.should respond_to attribute }
  end

end