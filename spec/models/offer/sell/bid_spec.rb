require 'rails_helper'

RSpec.describe Offer::Sell::Ask, type: :model do
  def valid_params
    {}
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

end

# == Schema Information
#
# Table name: offers
#
#  id               :integer          not null, primary key
#  type             :string
#  repo_type        :string
#  user_id          :integer
#  parent_id        :integer
#  position_id      :integer
#  counter_id       :integer
#  volume           :integer          default(1)
#  price            :float            default(0.5)
#  poolable         :boolean          default(TRUE)
#  aon              :boolean          default(FALSE)
#  status           :string
#  expiration       :datetime
#  maturation       :datetime
#  maturation_range :tsrange
#  jfields          :jsonb            not null
#  exref            :string
#  uuref            :string
#  stm_bug_id       :integer
#  stm_repo_id      :integer
#  stm_title        :string
#  stm_status       :string
#  stm_labels       :string
#  stm_xfields      :hstore           not null
#  stm_jfields      :jsonb            not null
#
