class Offer::Buy < Offer

  validate  :user_funds

  def intent
    "buy"
  end

  private

  def user_funds
    return unless id.nil?

    if user.nil?
      errors.add(:user, "must be present")
      return false
    end

    if value > user&.balance
      errors.add(:volume, "offer larger than user balance")
      return false
    end

    # TODO: fix this...
    # val1 = value - user.token_reserve_not_poolable
    # val2 = user.balance - user.token_reserve_poolable
    # unless 0 <= val1 && val1 < val2
    #   errors.add(:volume, "not enough funds in user account")
    #   return false
    # end
  end
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
