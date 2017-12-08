module DocfixEventsHelper
  def docfix_event_etherscan(eline)
    return ""
    return "" if eline.etherscan_url.blank?
    raw <<-ERB.strip_heredoc
      <a href="#{eline.etherscan_url}">Etherscan</a>
    ERB
  end
end
