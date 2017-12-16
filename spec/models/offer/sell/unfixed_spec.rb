require 'rails_helper'

RSpec.describe Offer::Sell::Fixed, type: :model do
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
#  id                  :integer          not null, primary key
#  type                :string
#  repo_type           :string
#  user_id             :integer
#  user_uuid           :integer
#  prototype_id        :integer
#  amendment_id        :integer
#  reoffer_parent_id   :integer
#  salable_position_id :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  value               :float
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
#  status              :string
#  expiration          :datetime
#  maturation_range    :tsrange
#  xfields             :hstore           not null
#  jfields             :jsonb            not null
#  exid                :string
#  uuid                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  stm_bug_id          :integer
#  stm_repo_id         :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
