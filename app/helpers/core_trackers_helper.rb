module CoreTrackersHelper
  def core_tracker_id_link(tracker)
    raw "<a href='/core/trackers/#{tracker.uuid}'>#{tracker.xid}</a>"
  end

  def core_tracker_name_link(tracker)
    truncate(tracker.name)
  end

  def core_tracker_offer_bu_new_link(tracker)
    path = "/core/offers_bu/new?type=git_hub&stm_tracker_uuid=#{tracker.uuid}"
    raw "<a href='#{path}'>unfixed</a>"
  end

  def core_tracker_offer_bf_new_link(tracker)
    path = "/core/offers_bf/new?type=git_hub&stm_tracker_uuid=#{tracker.uuid}"
    raw "<a href='#{path}'>fixed</a>"
  end

  def core_tracker_bug_link(tracker)
    count = tracker.issues.count
    if count > 0
      raw "<a class='buglink' href='/core/issues?stm_tracker_uuid=#{tracker.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_tracker_offer_link(tracker)
    count = tracker.offers.open.count
    if count > 0
      raw "<a class='offerlink' href='/core/offers?stm_tracker_uuid=#{tracker.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_tracker_contract_link(tracker)
    count  = tracker.contracts.count
    if count > 0
      raw "<a class='contractlink' href='/core/contracts?stm_tracker_uuid=#{tracker.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_tracker_destroy_link(tracker)
    return nil if tracker.has_contracts?
    link_to 'Destroy', { action: :destroy, id: tracker.uuid }, method: :delete, data: { confirm: 'Are you sure?' }
  end

  def tracker_actions(tracker)
    cbid  = core_tracker_offer_bu_new_link(tracker)
    cask  = core_tracker_offer_bf_new_link(tracker)
    csync = link_to "Sync", {:action => :sync, :id => tracker.uuid}
    cdest = core_tracker_destroy_link(tracker)
    # TODO: add sync and destroy
    # raw [cbid,cask,csync,cdest].select(&:present?).join(" | ")
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def core_tracker_http_link(tracker)
    return "NA" unless tracker.type == "Tracker::Github"
    url = tracker.html_url
    raw "<a href='#{url}' target='_blank'>#{url}</a>"
  end
end
