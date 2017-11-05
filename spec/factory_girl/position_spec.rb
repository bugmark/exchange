require 'rails_helper'

RSpec.describe 'Position Factory', USE_VCR do
  it "runs without params" do
    expect(Position.count).to eq(0)
    FG.create(:position)
    expect(Position.count).to eq(1)
  end

  it "gets the default side" do
    obj = FG.create(:position)
    expect(obj.side).to eq("unfixed")
  end

  it "creates a unfixed position" do
    obj = FG.create(:unfixed_position)
    expect(obj.side).to eq("unfixed")
  end

  it "creates an fixed position" do
    obj = FG.create(:fixed_position)
    expect(obj.side).to eq("fixed")
  end
end
