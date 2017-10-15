# require 'rails_helper'
#
RSpec.describe Offer::Ask, type: :model do

  def valid_params(user)
    {}
  end

  let(:klas)   { described_class                            }
  let(:user)   { FG.create(:user)                           }
  subject      { klas.new(valid_params(user))               }

end

# == Schema Information
#
# Table name: asks
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  contract_id         :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  all_or_none         :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  maturation_period   :tsrange
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
