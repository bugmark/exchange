require 'rails_helper'

RSpec.describe 'Position Factory', USE_VCR do
  it "runs without params" do
    expect(Position.count).to eq(0)
    FG.create(:position)
    expect(Position.count).to eq(1)
  end

  it "gets the default side" do
    obj = FG.create(:position)
    expect(obj.side).to eq("bid")
  end

  it "creates a bid position" do
    obj = FG.create(:bid_position)
    expect(obj.side).to eq("bid")
  end

  it "creates an ask position" do
    obj = FG.create(:ask_position)
    expect(obj.side).to eq("ask")
  end
end
