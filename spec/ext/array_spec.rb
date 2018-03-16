require 'rails_helper'
require 'ext/array'

RSpec.describe "ext/Array" do


  describe "#allsums" do
    it "works on case 1" do
      result = [1,2].allsums
      expect(result).to eq([0,1,2,3])
    end

    it "works on case 2" do
      result = [2,3,4].allsums
      expect(result).to eq([0,2,3,4,5,6,7,9])
    end
  end
end