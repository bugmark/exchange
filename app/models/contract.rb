class Contract < ApplicationRecord
  belongs_to :bug   , optional: true
  belongs_to :repo  , optional: true

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
#  repo_id         :integer
#  bug_id          :integer
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_amount :float
#  currency_type   :string
#  terms           :string
#  status          :string
#  labels          :text             default([]), is an Array
#  jfields         :jsonb            not null
#  expire_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
