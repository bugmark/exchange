require 'rails_helper'

RSpec.describe 'Position Factory' do
  it "runs without params" do
    expect(Position.count).to eq(0)
    FG.create(:position)
    expect(Position.count).to eq(1)
  end
end

