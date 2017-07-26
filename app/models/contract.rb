class Contract < ApplicationRecord
  belongs_to :bug   , optional: true
  belongs_to :repo  , optional: true

  # validates :currency_amount, numericality: {less_than: 15}

  before_save :default_values

  def matching_bugs
    @bugmatch ||= Bug.match(match_attrs)
  end

  private

  def default_values
    self.status       ||= 'open'
    self.assert_match ||= true
  end

  def match_attrs
    {
      id:      self.bug_id       ,
      repo_id: self.repo_id      ,
      title:   self.title        ,
      status:  self.status       ,
      labels:  self.labels
    }
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_type   :string
#  currency_amount :float
#  terms           :string
#  expire_at       :datetime
#  bug_id          :integer
#  repo_id         :integer
#  title           :string
#  status          :string
#  labels          :string
#  assert_match    :boolean
#  jfields         :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
