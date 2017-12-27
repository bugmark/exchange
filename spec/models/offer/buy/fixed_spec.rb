require 'rails_helper'

RSpec.describe Offer::Buy::Fixed, type: :model do
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
#  id                    :integer          not null, primary key
#  type                  :string
#  repo_type             :string
#  user_id               :integer
#  user_uuid             :string
#  prototype_id          :integer
#  prototype_uuid        :string
#  amendment_id          :integer
#  amendment_uuid        :string
#  reoffer_parent_id     :integer
#  reoffer_parent_uuid   :string
#  salable_position_id   :integer
#  salable_position_uuid :string
#  volume                :integer
#  price                 :float
#  value                 :float
#  poolable              :boolean          default(FALSE)
#  aon                   :boolean          default(FALSE)
#  status                :string
#  expiration            :datetime
#  maturation_range      :tsrange
#  xfields               :hstore           not null
#  jfields               :jsonb            not null
#  exid                  :string
#  uuid                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  stm_bug_id            :integer
#  stm_bug_uuid          :string
#  stm_repo_id           :integer
#  stm_repo_uuid         :string
#  stm_title             :string
#  stm_status            :string
#  stm_labels            :string
#  stm_xfields           :hstore           not null
#  stm_jfields           :jsonb            not null
#
