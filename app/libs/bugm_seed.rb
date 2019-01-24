class BugmSeed

  attr_reader :cycles, :num_users, :num_issues
  attr_reader :week_ends, :user_ids, :issue_ids, :volumes, :prices

  BMX_SAVE_EVENTS  = "FALSE"
  BMX_SAVE_METRICS = "FALSE"

  def initialize(opts = {})
    @cycles     = opts.fetch(:cycles,     15)
    @num_users  = opts.fetch(:num_users,  3)
    @num_issues = opts.fetch(:num_issues, 4)
  end

  def generate
    BugmHost.reset
    reset_system
    gen_users
    gen_issues

    @week_ends = BugmTime.next_week_ends
    @user_ids  = User.where("email ilike 'test%'").pluck(:uuid)
    @issue_ids = Issue.all[0..3].pluck(:uuid)
    @volumes   = (30..50).step(5).to_a
    @prices    = (5..95).step(5).to_a.map {|x| x / 100.0}
    @messages  = []

    cycles.times do |cyc|
      count = cyc + 1
      time  = Time.now.strftime("%H:%M:%S")
      log_gen(count, time)
      buy
      cross if count % 2 == 0
    end
    stat_gen
    self
  end

  def log_show
    puts "----- GENERATE BUGMARK SEED DATA -----------------------------------"
    puts @messages.join("\n")
    stat_show
  end

  def stat_show
    puts "Num users:     #{@stat_users}"
    puts "Num issues:    #{@stat_issues}"
    puts "Num contracts: #{@stat_contracts}"
    puts "Num escrows:   #{@stat_escrows}"
    puts "Num offers:    #{@stat_offers}"
    puts "Num events:    #{@stat_events}"
  end

  private

  def reset_system
    BugmHost.reset
  end

  def stat_gen
    @stat_users     = User.count
    @stat_issues    = Issue.count
    @stat_contracts = Contract.count
    @stat_escrows   = Escrow.count
    @stat_offers    = Offer.count
    @stat_events    = Event.count
  end

  def log_gen(count, time)
    cycle     = "Cycle: #{pa count}"
    offers    = "#{pa Offer.open.count} open offers"
    contracts = "#{pa Contract.count} contracts"
    escrows   = "#{pa Escrow.count} escrows"
    all       = [cycle, offers, contracts, escrows].join(" | ")
    @messages << all
  end

  def buy
    typ  = %i(offer_bf offer_bu).sample
    opts = {
      user_uuid:      user_ids.sample     ,
      volume:         volumes.sample      ,
      price:          prices.sample       ,
      stm_issue_uuid: issue_ids.sample    ,
      maturation:     week_ends.sample
    }
    FB.create(typ, opts)
  end

  def cross
    print "Crossing"
    Offer.open.is_buy.each do |offer|
      print "."
      ContractCmd::Cross.new(offer, :expand).project
    end
    puts "."
  end

  def pa(el)
    el.to_s.rjust(2, "0")
  end

  def gen_users
    num_users.times do |idx|
      FB.create :user, email: "test#{idx + 1}@bugmark.net"
    end
  end

  def gen_issues
    tracker = FB.create(:tracker).tracker
    num_issues.times do
      FB.create :issue, stm_tracker_uuid: tracker.uuid
    end
  end
end
