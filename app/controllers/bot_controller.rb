class BotController < ApplicationController

  layout 'bot'

  before_action :authenticate_user!, except: [:build_msg, :build_log, :log_show]
  
  BOT_LOG   = "/tmp/bot_log.txt"
  BUILD_LOG = "/tmp/build_log.txt"
  HISTORY   = "/tmp/history.txt"
  PROC_NAME = "bot_buy"

  def home
  end

  def time
    @history = get_history
  end

  def timeinc
    Bug.open[0..2].each do |bug|
      bug.update_attribute :stm_status, 'closed'
    end
    BugmTime.increment_day_jump(8)
    Contract.matured.unresolved.each do |cnt|
      ContractCmd::Resolve.new(cnt).project
    end
    flash[:notice] = "System Days Offset: #{BugmTime.day_offset} days"
    redirect_to "/bot/time"
  end

  def new_login
    redirect_to "/bot/home"
  end

  def new_signup
    redirect_to "/bot/home"
  end
  
  def build
    system "pkill -f #{PROC_NAME}"
    system "(sleep 2 ; script/data/all_reload) > #{BUILD_LOG} 2>&1 &"
    flash[:notice] = "BUILD HAS STARTED"
    redirect_to "/bot/build_msg"
  end

  def build_msg
    @logtext = read_file(BUILD_LOG)
  end
  
  def build_log
    @logtext = read_file(BUILD_LOG)
  end
  
  def start
    system "pkill -f #{PROC_NAME}"
    system "echo 'RESET LOG at #{BugmTime.now}' > #{BOT_LOG}"
    system "stdbuf -oL script/bot/buy >> #{BOT_LOG} 2>&1 &"
    sleep 0.5
    flash[:notice] = "BOT HAS STARTED"
    redirect_to "/bot/log_show"
  end

  def stop
    system "pkill -f #{PROC_NAME}"
    flash[:notice] = "BOT HAS STOPPED"
    redirect_to "/bot/log_show"
  end

  def log_show
    @logtext = read_file(BOT_LOG)
  end

  def log_reset
    system "echo 'RESET LOG at #{BugmTime.now}' > #{BOT_LOG}"
    flash[:notice] = "BOT LOG WAS RESET"
    redirect_to "/bot/log_show"
  end

  private

  def read_file(path)
    data = File.exist?(path) ? File.read(path).gsub("\n", "<br\>") : ""
    data.empty? ? "NO LOG DATA" : data
  end

  def get_history
    history = History.new(HISTORY, current_user)
    history.update
    history
  end
end

