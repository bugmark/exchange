require 'ext/hash'

class Offer::Sell::Fixed < Offer::Sell

  def side()     "fixed"   end
  def cmd_type() :offer_sf end
  alias_method :xtag, :side

  def qualified_counteroffers(cross_type = :transfer)
    return Offer.none unless self.is_open?
    base = match.open.overlaps(self)
    case cross_type
      when :transfer then base.is_buy_fixed.align_gte(self)
      when :reduce   then base.is_sell_unfixed.align_complement(self)
      else Offer.none
    end
  end
  alias_method :counters, :qualified_counteroffers

  # ----- for building counteroffers
  #
  # counter = OfferCmd::CreateBuy.new(offer.counter_type, offer.counter_args(current_user))
  # cross   = ContractCmd::Cross.new(counter, offer.cross_operation)

  def counter_type()    :offer_bf  end
  def cross_operation() :transfer  end
  def counter_args(user = self.user)
    args = {
      user:             user                   ,
      maturation_range: self.maturation_range  ,
    }
    self.match_attrs.merge(args).without_blanks
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
