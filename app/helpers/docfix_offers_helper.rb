module DocfixOffersHelper
  def docfix_offer_madlib_dates
    eow = Time.now.end_of_week
    all = [eow, eow + 1.week, eow + 2.weeks, eow + 3.weeks]
    lst = all.map.with_index do |date, idx|
      data = date.strftime("%y-%m-%d")
      labl = date.strftime("%b %e")
      <<-ERB.strip_heredoc
        <button id='btn#{idx + 1}' class='btn btn-secondary bc' data-md="#{data}">
          #{labl}        
        </button>
      ERB
    end
    raw lst.join
  end

  # -----
  def docfix_offer_show_link(offer)
    raw <<-ERB.strip_heredoc
      <b>
      <a href="/docfix/offers/#{offer.id}">#{docfix_offer_title(offer)}</a>
      </b>
      <br/>
      #{docfix_offer_pill(offer)}
    ERB
  end

  def docfix_offer_header(offer)
    raw docfix_offer_title(offer)
  end

  def docfix_offer_title(offer)
    "Offer ##{offer.id} for #{docfix_offer_assoc(offer)}"
  end

  def docfix_offer_pill(offer)
    labl_txt = "unmatched on #{offer.side}".upcase
    labl_cls = offer.side == 'fixed' ? 'default' : 'info'
    "<span class='badge badge-#{labl_cls}'>#{labl_txt}</span>"
  end

  def docfix_offer_assoc(offer)
    case
      when offer.stm_bug_id
        "issue ##{offer.stm_bug_id}"
      when offer.stm_repo_id
        "repo ##{offer.stm_repo_id}"
      else ""
    end
  end

  # -----

  def docfix_offer_price(offer)
    op = (offer.price * 100).to_i
    cp = 100 - op
    fp, up = offer.is_fixed? ? [op, cp] : [cp, op]
    raw <<-HTML.strip_heredoc
      <table>
        <tr>
          <td style='padding: 10px; text-align: center; border-right: 1px solid black;'>
            #{fp}%<br/><small>on fixed side</small>
          </td>
          <td style='padding: 10px; text-align: center;'>
            #{up}%<br/><small>on unfixed side</small>
          </td>
        </tr>
      </table>
    HTML
  end

  # -----

  def docfix_offer_assoc_link(offer)
    case
      when offer.stm_bug_id
        docfix_offer_issue_link(offer)
      when offer.stm_repo_id
        docfix_offer_project_link(offer)
      else
        ""
    end
  end

  def docfix_offer_assoc_label(offer)
    case
      when offer.stm_bug_id
        "Issue"
      when offer.stm_repo_id
        "Project"
      else ""
    end
  end

  def docfix_offer_issue_link(offer)
    raw <<-END.strip_heredoc
      <a href="/docfix/issues/#{offer.stm_bug_id}">
        #{offer.bug.stm_title} (Issue ##{offer.stm_bug_id})
      </a>
    END
  end

  def docfix_offer_project_link(offer)
    raw <<-END.strip_heredoc
      <a href="/docfix/projects/#{offer.stm_repo_id}">
        #{offer.repo.name} (Project ##{offer.stm_repo_id})
      </a>
    END
  end

  # ----- issue buttons -----

  def docfix_offer_buy_btns(offer)
    bug = offer.bug
    return "" unless bug.present?
    docfix_issue_bu_btn(bug) + docfix_issue_bf_btn(bug)
  end
end
