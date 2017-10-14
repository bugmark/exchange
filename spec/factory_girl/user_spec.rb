require 'rails_helper'

RSpec.describe 'User Factory' do

  it "runs without params" do
    expect(User.count).to eq(0)
    FG.create(:user)
    expect(User.count).to eq(1)
  end
end
