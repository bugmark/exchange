require 'rails_helper'

RSpec.describe 'Position Factory', USE_VCR do
  it "runs without params" do
    expect(Position.count).to eq(0)
    FG.create(:position)
    expect(Position.count).to eq(1)
  end

  it "gets the right side" do
    obj = FG.create(:position)
    expect(obj.side).to eq("bid")
  end
end

