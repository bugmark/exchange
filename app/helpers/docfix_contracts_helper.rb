module DocfixContractsHelper

  # -----
  
  def docfix_contract_id_link(contract)
    raw "<a href='/docfix/contracts/#{contract.id}'>#{contract.xid}</a>"
  end

  def core_amend_positions_link(amend)
    raw amend.positions.map {|pos| core_position_link(pos)}.join(" | ")
  end

  def core_amend_bid_positions_link(amend)
    ""
    # raw amend.bid_positions.map {|pos| core_position_link(pos)}.join(" | ")
  end

  def core_amend_ask_positions_link(amend)
    # raw amend.ask_positions.map {|pos| core_position_link(pos)}.join(" | ")
    ""
  end

  def core_amend_bid_positions_stats(amend)
    # raw amend.bid_positions.map {|pos| "<i>#{pos.volume}@#{pos.price}</i>"}.join(" | ")
    ""
  end

  def core_amend_ask_positions_stats(amend)
    # raw amend.ask_positions.map {|pos| "<i>#{pos.volume}@#{pos.price}</i>"}.join(" | ")
    ""
  end

  def core_amend_escrow_stats(amend)
    # raw "<i>#{amend.escrow.bid_value}</i>/<i>#{amend.escrow.ask_value}</i>"
    ""
  end

  def docfix_contract_bid_link(contract)
    # raw contract.bids.map {|b| bid_id_link(b)}.join(" | ")
    ""
  end

  def docfix_contract_ask_link(contract)
    # raw contract.asks.map {|a| ask_id_link(a)}.join(" | ")
    ""
  end

  def docfix_contract_type_link(contract)
    type = contract.xtype
    raw "<a href='/rewards/#{contract.id}'>#{type}</a>"
  end

  def docfix_contract_mature_date(contract)
    color = BugmTime.now > contract.maturation ? "red" : "green"
    date = contract.maturation
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def docfix_contract_status(contract)
    case contract.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "matured"  then raw "<i class='fa fa-lock'></i> matured"
      when "resolved" then raw "<i class='fa fa-check'></i> resolved"
      else "UNKNOWN_CONTRACT_STATE"
    end
  end

  def docfix_contract_awardee(contract)
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

  def docfix_contract_resolve_link(contract)
    return nil if contract.resolved?
    return nil unless contract.matured?
    link_to "resolve", "/docfix/contracts/#{contract.id}/resolve"
  end

  def docfix_contract_actions(contract)
    resv  = docfix_contract_resolve_link(contract)
    return "NA" unless [resv].any?
    raw [resv].select(&:present?).join(" | ")
  end

  # ----- issue buttons -----

  def docfix_contract_action_btns(contract)
    bug = contract.bug
    return "" unless bug.present?
    raw <<-HTML.strip_heredoc
    <a class='btn btn-secondary' style='width: 100%; margin: 5px;' href='/docfix/issues/#{bug.id}/offer_buy'>
      <b>MAKE NEW<br/>INVEST</b><br/>
    </a>
    HTML
  end

  # -----

  def docfix_contract_show_link(contract)
    raw <<-ERB.strip_heredoc
      <b>
      <a href="/docfix/contracts/#{contract.id}">#{docfix_contract_title(contract)}</a>
      </b>
    ERB
  end

  def docfix_contract_title(contract)
    "Contract ##{contract.id} for #{docfix_contract_assoc(contract)}"
  end

  def docfix_contract_hdr(contract)
    link_txt = "contract ##{contract.id} for #{docfix_contract_assoc(contract)}"
    labl_txt = "unmatched on #{contract.side}".upcase
    labl_cls = contract.side == 'fixed' ? 'default' : 'info'
    raw <<-END.strip_heredoc
      <b>
      <a href="/docfix/contracts/#{contract.id}">#{link_txt}</a>
      </b>
      <br/>
      <span class='badge badge-#{labl_cls}'>#{labl_txt}</span>
    END
  end

  def docfix_contract_assoc(contract)
    case
      when contract.stm_bug_id
        "issue ##{contract.stm_bug_id}"
      when contract.stm_repo_id
        "repo ##{contract.stm_repo_id}"
      else ""
    end
  end

  # -----

  def docfix_contract_price(contract)
    esc = contract.escrows.last
    fp = esc.fixed_positions.first.price.round(2)
    up = esc.unfixed_positions.first.price.round(2)
    raw <<-HTML.strip_heredoc
      <table>
        <tr>
          <td style='text-align: center; border-right: 1px solid black; padding: 5px; border-top: 0px;'>
            #{fp}%<br/><small>on fixed side</small>
          </td>
          <td style='text-align: center; padding: 5px; border-top: 0px;'>
            #{up}%<br/><small>on unfixed side</small>
          </td>
        </tr>
      </table>
    HTML
  end

  # -----

  def docfix_contract_assoc_link(contract)
    case
      when contract.stm_bug_id
        docfix_contract_issue_link(contract)
      when contract.stm_repo_id
        docfix_contract_project_link(contract)
      else
        ""
    end
  end

  def docfix_contract_assoc_label(contract)
    case
      when contract.stm_bug_id
        "Issue"
      when contract.stm_repo_id
        "Project"
      else ""
    end
  end

  def docfix_contract_issue_link(contract)
    raw <<-END.strip_heredoc
      <a href="/core/issues/#{contract.stm_bug_id}">
        #{contract.bug.stm_title}
      </a>
    END
  end

  def docfix_contract_project_link(contract)
    raw <<-END.strip_heredoc
      <a href="/core/projects/#{contract.stm_repo_id}">
        #{contract.repo.name}
      </a>
    END
  end
end