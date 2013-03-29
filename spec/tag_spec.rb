require "./app"

describe Tag do

  it "should show the list of tags" do
    Tag.all.should have(3).items
  end


end