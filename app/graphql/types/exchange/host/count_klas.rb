class Types::Exchange::Host::CountKlas
  def users()          User.count                      end
  def trackers()       Tracker.count                   end
  def issues()         Issue.count                     end
  def offers()         Offer.count                     end
  def offers_open()    Offer.open.count                end
  def offers_open_bf() Offer.open.is_buy_fixed.count   end
  def offers_open_bu() Offer.open.is_buy_unfixed.count end
  def contracts()      Contract.count                  end
  def contracts_open() Contract.open.count             end
  def positions()      Position.count                  end
  def amendments()     Amendment.count                 end
  def escrows()        Escrow.count                    end
  def events()         Event.count                     end
end

