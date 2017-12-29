module ApplicationHelper

  def bugm_new_login_path
    "/#{current_layout}/new_login"
  end

  def bugm_new_signup_path
  "/#{current_layout}/new_signup"
  end

  def current_layout
    controller.send :_layout, ["no_op_argument"]
  end

  def refreshable?
    %w(bot#log_show bot#build_log bot#build_msg).include?(debug_lbl)
  end

  # -----

  def obj_link(event)
    return  ""
    return event.klas unless event.klas == "ContractCmd::Cross"
    raw <<-EOF
      <a href="/docfix/contracts/#{event.data['id']}"}>
        ContractCmd::Cross
      </a>
    EOF
  end

  # -----

  def issue_links
    num_open   = Bug.open.count
    num_closed = Bug.closed.count
    "Open #{num_open} | Closed #{num_closed}"
  end

  # -----

  def contract_links
    num_open     = Contract.open.count
    num_resolved = Contract.resolved.count
    "Open #{num_open} | Resolved #{num_resolved}"
  end

  # -----

  def refresh_tag
    dev_log "PAGE #{debug_lbl}"
    return "" unless refreshable?
    raw "<meta http-equiv='refresh' content='15' />"
  end

  def flash_alert(flash)
    alt = flash.to_hash.stringify_keys
    alt["success"] ||= alt.delete("notice")
    alt["danger"]  ||= alt.delete("alert")
    alt["danger"]  ||= alt.delete("error")
    keys = %w(primary secondary success danger warning info light dark)
    return "" unless key = keys.find {|k| alt[k]}
    raw """
    <div class='alert alert-#{key}' role='alert'>#{alt[key]}</div>
    """
  end

  def breadcrumb(list)
    head = list[0..-2].map do |elem|
      lbl, lnk = elem
      "<li class='breadcrumb-item'><a href='#{lnk}'>#{lbl}</a></li>"
    end.join
    lbl = Array(list[-1]).first
    tail = "<li class='breadcrumb-item active' area-current='page'>#{lbl}</li>"
    raw "<ol class='breadcrumb'>#{head}#{tail}</ol>"
  end

  def timestamp
    BugmTime.now.strftime("%H:%M:%S")
  end

  def debug_lbl
    "#{params["controller"]}##{params["action"]}"
  end

  def debug_text
    "<b>#{debug_lbl}</b>"
  end

  def nav_text(text)
    raw "<span class='navbar-text'>#{text}</span>"
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
    offer_count = user.offers.open.count
    """
    <em>#{user.email}</em></br>
    #{offer_count} open #{"offer".pluralize(offer_count)}</br>
    #{user.positions.count} positions</br>
    #{user.balance} balance</br>
    #{user.token_available} available
    """
  end

  def app_trading_summary(user)
    raw "<span class='ttip' data-html='true' data-placement='bottom' title='#{ttip_content(user)}'>#{user.sname}</span>"
  end

  def app_user_path(user)
    layout = controller.send(:_layout, ["no_op_arg"])
    # binding.pry
    case layout.to_s
      when "docfix" then docfix_user_path(user)
      when "core"   then core_user_path(user)
      else docfix_user_path(user)
    end
  end
end
