module DocfixOffersHelper
  def docfix_offer_hdr(offer)
    link_txt = "Offer ##{offer.id} for #{docfix_offer_assoc(offer)}"
    labl_txt = "unmatched on #{offer.side}".upcase
    labl_cls = offer.side == 'fixed' ? 'default' : 'info'
    raw <<-END.strip_heredoc
      <b>
      <a href="/docfix/offers/#{offer.id}">#{link_txt}</a>
      </b>
      <br/>
      <span class='badge badge-#{labl_cls}'>#{labl_txt}</span>
    END
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

  def docfix_assoc_link(offer)
    case
      when offer.stm_bug_id
        docfix_offer_issue_link(offer)
      when offer.stm_repo_id
        docfix_offer_project_link(offer)
      else
        ""
    end
  end

  def docfix_offer_label(offer)
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
        #{offer.bug.stm_title}
      </a>
    END
  end

  def docfix_offer_project_link(offer)
    raw <<-END.strip_heredoc
      <a href="/docfix/projects/#{offer.stm_repo_id}">
        #{offer.repo.name}
      </a>
    END
  end
end
