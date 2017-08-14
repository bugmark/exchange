require 'rails_helper'

RSpec.describe 'Contract Factory' do

  it "runs without params" do
    expect(Repo.count).to     eq(0)
    expect(User.count).to     eq(0)
    expect(Bug.count).to      eq(0)
    expect(Contract.count).to eq(0)
    FG.create(:contract)
    expect(Repo.count).to     eq(1)
    expect(User.count).to     eq(1)
    expect(Bug.count).to      eq(1)
    expect(Contract.count).to eq(1)
  end

end

