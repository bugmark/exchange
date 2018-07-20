require 'rails_helper'

RSpec.describe 'UserGroup Factory' do
  it "runs without params" do
    expect(User.count).to eq(0)
    expect(UserGroup.count).to eq(0)
    FB.create(:user_group)
    expect(User.count).to eq(1)
    expect(UserGroup.count).to eq(1)
  end
end
