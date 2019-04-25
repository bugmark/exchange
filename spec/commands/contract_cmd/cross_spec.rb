require 'rails_helper'

RSpec.describe ContractCmd::Cross do

  include_context'FactoryBot'

  def offer_args(user, alt = {})
    {
      user_uuid:      user.uuid         ,
      stm_issue_uuid: issue.uuid        ,
      maturation:     Time.now - 1.day
    }.merge(alt)
  end

  def gen_offer(usr, type, args = {})
    FB.create(type, offer_args(usr, args)).offer
  end

  let(:issue)   { FB.create(:issue).issue                       }
  let(:obf)     { gen_offer(usr1, :offer_bf)                    }
  let(:obu)     { gen_offer(usr2, :offer_bu)                    }
  let(:alt_obf) { gen_offer(usr2, :offer_bf, {price: 0.9})      }
  let(:alt_obu) { gen_offer(usr2, :offer_bu, {price: 0.1})      }
  let(:klas)    { described_class                               }
  subject       { klas.new(obf, :expand)                        }

  describe 'Attributes' do
    # it { should respond_to :offer           }
    # it { should respond_to :counters        }
    # it { should respond_to :type            }
  end

  describe 'Object Existence' do
    # it { should be_a klas       }
    # it { should_not be_valid    }
  end

  describe 'expand' do
    # it 'should work with two offers in the system' do
    #   hydrate(obf, obu)
    #   expect(Offer.open.count).to eq(2)
    #   expect(Contract.count).to eq(0)
    #   expect(subject.valid?).to be(true)
    #   klas.new(obf, :expand).project
    #   expect(Offer.open.count).to eq(0)
    #   expect(Contract.count).to eq(1)
    # end
  end

  describe 'expand with a target offer' do
    context 'with two offers in the system' do
      # it 'should perform a best-fit match' do
      #   hydrate(obf, obu)
      #   expect(Offer.open.count).to eq(2)
      #   expect(Contract.count).to eq(0)
      #   expect(subject.valid?).to be(true)
      #   klas.new(obf, :expand, obu).project
      #   expect(Offer.open.count).to eq(0)
      #   expect(Contract.count).to eq(1)
      # end

      # it 'should best-fit match with different prices' do
      #   hydrate(alt_obf, alt_obu)
      #   expect(Offer.open.count).to eq(2)
      #   expect(Contract.count).to eq(0)
      #   klas.new(alt_obf, :expand, alt_obu).project
      #   expect(Offer.open.count).to eq(0)
      #   expect(Contract.count).to eq(1)
      # end

      # it 'should not perform an explicit match with bad pricing' do
      #   hydrate(obf, alt_obf)
      #   expect(Offer.open.count).to eq(2)
      #   expect(Contract.count).to eq(0)
      #   # NOTE: is isn't behaving as expected
      #   # We are getting a cross - should not happen
      #   # Look at the offer prices - they should not overlap
      #   result = klas.new(obf, :expand, alt_obf).project
      #   expect(Offer.open.count).to eq(2)
      #   expect(Contract.count).to eq(0)
      # end #
    end

    context 'with three offers in the system' do
      # it 'should perform an explicit match' do
      #   hydrate(obf, alt_obf, alt_obu)
      #   expect(Offer.open.count).to eq(3)
      #   expect(Contract.count).to eq(0)
      #   klas.new(alt_obf, :expand, alt_obu).project
      #   expect(Offer.open.count).to eq(1)
      #   expect(Offer.crossed.count).to eq(2)
      #   expect(Contract.count).to eq(1)
      #   expect(obf.status).to eq('open')
      # end

      it 'should perform a best-fit match' do
        hydrate(alt_obf, alt_obu, obu)
        expect(Offer.open.count).to eq(3)
        expect(alt_obu.qualified_counteroffers.count).to eq(1)
        expect(alt_obf.qualified_counteroffers.count).to eq(2)
        expect(obu.qualified_counteroffers.count).to eq(1)
        klas.new(alt_obf, :expand).project
        expect(Offer.open.count).to eq(1)
        expect(Offer.crossed.count).to eq(2)
        expect(Contract.count).to eq(1)
        alt_obu.reload
        alt_obf.reload
        expect(alt_obu.status).to eq("crossed")
        expect(alt_obf.status).to eq("crossed")
      end

      it 'should perform a best-fit match' do
        # TODO - it looks to us like this is not matching correctly
        # each offer should have TWO qualified counteroffers - we think...
        hydrate(alt_obf, alt_obu, obu, obf)
        expect(Offer.open.count).to eq(4)
        expect(alt_obu.qualified_counteroffers.count).to eq(1)
        expect(alt_obf.qualified_counteroffers.count).to eq(2)
        expect(obu.qualified_counteroffers.count).to eq(2)
        expect(obf.qualified_counteroffers.count).to eq(1)
        require 'pry'; binding.pry #
        # klas.new(alt_obf, :expand).project
        # expect(Offer.open.count).to eq(1)
        # expect(Offer.crossed.count).to eq(2)
        # expect(Contract.count).to eq(1)
        # alt_obu.reload
        # alt_obf.reload
        # expect(alt_obu.status).to eq("crossed")
        # expect(alt_obf.status).to eq("crossed")
      end
    end


  end

  describe 'pricing' do
    # it 'handles media' do
    #   o1 = gen_offer(usr1, :offer_bf, {price: 0.1 })
    #   o2 = gen_offer(usr2, :offer_bu, {price: 0.9 })
    #   klas.new(o1, :expand).project
    #   expect(Offer.open.count).to eq(0)
    #   expect(Contract.count).to eq(1)
    # end

    # it 'handles zero' do
    #   o1 = gen_offer(usr1, :offer_bf, {price: 0.0 })
    #   o2 = gen_offer(usr2, :offer_bu, {price: 1.0 })
    #   klas.new(o1, :expand).project
    #   expect(Offer.open.count).to eq(0)
    #   expect(Contract.count).to eq(1)
    # end

    # it "handles zero" do
    #   o1 = gen_offer(usr1, :offer_bf, {price: 1.0 })
    #   o2 = gen_offer(usr2, :offer_bu, {price: 0.0 })
    #   klas.new(o1, :expand).project
    #   expect(Offer.open.count).to eq(0)
    #   expect(Contract.count).to eq(1)
    # end
  end
end
