class Offer::Buy < Offer

  validate  :user_funds

  private

  def user_funds
    return unless id.nil?

    if user.nil?
      errors.add(:user, "must be present")
      return
    end

    if reserve_value > user&.token_balance
      errors.add(:volume, "offer larger than user balance")
      return
    end

    val1 = reserve_value - user.token_reserve_not_poolable
    val2 = user.token_balance - user.token_reserve_poolable
    unless 0 <= val1 && val1 < val2
      errors.add(:volume, "not enough funds in user account")
    end
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  type                :string
#  repo_type           :string
#  user_id             :integer
#  parent_id           :integer
#  position_id         :integer
#  counter_id          :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
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
