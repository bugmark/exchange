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
#  id                    :bigint(8)        not null, primary key
#  uuid                  :string
#  exid                  :string
#  type                  :string
#  tracker_type          :string
#  user_uuid             :string
#  prototype_uuid        :string
#  amendment_uuid        :string
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
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  stm_issue_uuid        :string
#  stm_tracker_uuid      :string
#  stm_title             :string
#  stm_body              :string
#  stm_status            :string
#  stm_labels            :string
#  stm_comments          :jsonb            not null
#  stm_jfields           :jsonb            not null
#  stm_xfields           :hstore           not null
#
