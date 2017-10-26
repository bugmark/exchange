module CoreUsersHelper

  def core_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/core/users/#{usr.id}'>#{usr.xid}</a>"
  end

end
