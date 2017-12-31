require 'rails_helper'

RSpec.describe 'FbxPositionU', USE_VCR do

  describe "postion_f" do
    it "runs without params" do
      expect(Offer.count).to    eq(0)
      expect(Contract.count).to eq(0)
      expect(Escrow.count).to   eq(0)
      expect(Position.count).to eq(0)
      result = FBX.position_u
      expect(result).to be_present
      expect(result).to be_a(Position)
      expect(Offer.is_buy.count).to  eq(2)
      expect(Offer.is_sell.count).to eq(0)
      expect(Contract.count).to      eq(1)
      expect(Escrow.count).to        eq(1)
      expect(Position.count).to      eq(2)
    end
  end

end
