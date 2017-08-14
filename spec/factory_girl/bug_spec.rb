require 'rails_helper'

RSpec.describe 'Bug Factory' do

  it "runs without params" do
    expect(Bug.count).to eq(0)
    FG.create(:bug)
    expect(Bug.count).to eq(1)
  end

end

