module CoreContractsHelper
  def core_contract_id_link(contract)
    raw "<a href='/core/contracts/#{contract.id}'>#{contract.xid}</a>"
  end

  def core_amend_positions_link(amend)
    raw amend.positions.map {|pos| core_position_link(pos)}.join(" | ")
  end

  def core_amend_bid_positions_link(amend)
    raw amend.bid_positions.map {|pos| core_position_link(pos)}.join(" | ")
  end

  def core_amend_ask_positions_link(amend)
    raw amend.ask_positions.map {|pos| core_position_link(pos)}.join(" | ")
  end

  def core_amend_bid_positions_stats(amend)
    raw amend.bid_positions.map {|pos| "<i>#{pos.volume}@#{pos.price}</i>"}.join(" | ")
  end

  def core_amend_ask_positions_stats(amend)
    raw amend.ask_positions.map {|pos| "<i>#{pos.volume}@#{pos.price}</i>"}.join(" | ")
  end

  def core_amend_escrow_stats(amend)
    raw "<i>#{amend.escrow.bid_value}</i>/<i>#{amend.escrow.ask_value}</i>"
  end

  def core_contract_bid_link(contract)
    # raw contract.bids.map {|b| bid_id_link(b)}.join(" | ")
    ""
  end

  def core_contract_ask_link(contract)
    # raw contract.asks.map {|a| ask_id_link(a)}.join(" | ")
    ""
  end

  def core_contract_type_link(contract)
    type = contract.xtype
    raw "<a href='/rewards/#{contract.id}'>#{type}</a>"
  end

  def core_contract_mature_date(contract)
    color = BugmTime.now > contract.maturation ? "red" : "green"
    date = contract.maturation_str
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def core_contract_status(contract)
    case contract.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "matured"  then raw "<i class='fa fa-lock'></i> matured"
      when "resolved" then raw "<i class='fa fa-check'></i> resolved"
        else "UNKNOWN_CONTRACT_STATE"
    end
  end

  def core_contract_awardee(contract)
    icon, lbl = if contract.resolved?
      usr = contract.awardee_user
      lbl = "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
      ["check", lbl]
    else
      ["gears", contract.awardee]
    end
    raw "<i class='fa fa-#{icon}'></i> #{lbl}"
  end

  # ----- ACTIONS -----

  def core_contract_resolve_link(contract)
    return nil if contract.resolved?
    return nil unless contract.matured?
    link_to "resolve", "/core/contracts/#{contract.id}/resolve"
  end

  def core_contract_actions(contract)
    resv  = core_contract_resolve_link(contract)
    return "NA" unless [resv].any?
    raw [resv].select(&:present?).join(" | ")
  end

end
