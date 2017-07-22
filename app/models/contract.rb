class Contract < ApplicationRecord
  belongs_to :bug

  before_save :default_values

  def default_values
    self.status ||= 'open'
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  bug_id          :integer
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_amount :float
#  currency_type   :string
#  terms           :string
#  jfields         :jsonb            not null
#  expire_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
