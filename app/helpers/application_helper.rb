module ApplicationHelper

  def debug_text
    "<b>#{params["controller"]}##{params["action"]}</b>"
  end

  def nav_link(label, path, opts = {})

    delopt = opts[:method] == "delete"

    delstr = delopt ? "rel='nofollow' data-method='delete'" : ""

    ext1, ext2 = if current_page?(path) then
      ["active", '<span class="sr-only">(current)</span>']
    else
      ["", ""]
    end

    raw %{
      <li class="nav-item #{ext1}">
        <a class="nav-link" #{delstr} href="#{path}">#{label} #{ext2}</a>
      </li>
    }
  end

  def ttip_content(user)
    """
    <em>#{user.xid}</em></br>
    #{user.asks.count} asks</br>
    #{user.bids.count} bids</br>
    #{user.contracts.count} contracts</br>
    #{user.balance} tokens
    """
  end

  def trading_summary(user)
    # balance  = user.balance
    balance  = user.token_available
    raw "<span class='ttip' data-html='true' data-placement='bottom' title='#{ttip_content(user)}'>#{user.email} / #{balance} tokens</span>"
  end

end
