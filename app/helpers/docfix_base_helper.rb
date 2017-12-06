module DocfixBaseHelper

  def docfix_offer_base_opts(params = {}, alt_opts = {})
    {
      price:       0.50                     ,
      poolable:    false                    ,
      aon:         false                    ,
      volume:      10                       ,
      user_id:     current_user.id          ,
      status:      "open"                   ,
      stm_status:  "closed"                 ,
      maturation:  BugmTime.now + 3.minutes     ,
    }.merge(params).merge(alt_opts).without_blanks.stringify_keys
  end
end
