module UserBalance

  def user
    offer_new&.user
  end

  private

  def user_not_poolable_balance
    offer_value = offer_new.value || offer_new.volume * offer_new.price
    return true unless offer_value > user.token_available
    errors.add "volume", "non-poolable offer exceeds user balance"
    return false
  end

  def user_poolable_balance
    offer_value = offer_new.value || offer_new.volume * offer_new.price
    if (user.balance - offer_value - user.token_reserve_not_poolable) > 0
      return true
    else
      errors.add "volume", "poolable offer exceeds user balance"
      return false
    end
  end

  def valid_user_balance
    return true if offer_new.persisted?
    return false unless offer_new.valid?
    offer_new.poolable ? user_poolable_balance : user_not_poolable_balance
  end
end
