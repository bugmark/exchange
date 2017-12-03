module DocfixContractsHelper

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
          <td style='text-align: center; border-right: 1px solid black; padding: 5px;'>
            #{fp}%<br/><small>on fixed side</small>
          </td>
          <td style='text-align: center; padding: 5px;'>
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
      <a href="/docfix/issues/#{contract.stm_bug_id}">
        #{contract.bug.stm_title}
      </a>
    END
  end

  def docfix_contract_project_link(contract)
    raw <<-END.strip_heredoc
      <a href="/docfix/projects/#{contract.stm_repo_id}">
        #{contract.repo.name}
      </a>
    END
  end
end