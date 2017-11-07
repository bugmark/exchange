module ProfileHelper

  def profile_nav
    current = request.path
    paths   = %w(my_issues my_offers my_contracts saved_searches my_watchlist my_wallet settings)
    links   = paths.map do |path|
      modifier = current == "/docfix/profile/#{path}" ? "active" : ""
      lbl      = path.capitalize.gsub("_", " ")
      """
      <li class='nav-item'>
        <a class='nav-link #{modifier}' href='/docfix/profile/#{path}'>#{lbl}</a>
      </li>
      """
    end
    raw """
    <ul class='nav nav-tabs'>
      #{links.join}
    </ul>
    """
  end
end
