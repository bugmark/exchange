class BotController < ApplicationController

  layout 'home'

  before_action :authenticate_user!, except: [:build_log, :log_show]
  
  BOT_LOG   = "/tmp/bot_log.txt"
  BUILD_LOG = "/tmp/build_log.txt"
  PROC_NAME = "bot_buy"

  def home
  end
  
  def build
    system "pkill -f #{PROC_NAME}"
    system "(sleep 2 ; script/data/all_reload) > #{BUILD_LOG} 2>&1 &"
    flash[:notice] = "BUILD HAS STARTED"
    redirect_to "/bot/build_msg"
  end

  def build_msg
  end
  
  def build_log
    @logtext = read_file(BUILD_LOG)
  end
  
  def start
    system "pkill -f #{PROC_NAME}"
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
    system "echo 'RESET LOG at #{Time.now}' > #{BOT_LOG}"
    flash[:notice] = "BOT LOG WAS RESET"
    redirect_to "/bot/log_show"
  end

  private

  def read_file(path)
    data = File.exist?(path) ? File.read(path).gsub("\n", "<br\>") : ""
    data.empty? ? "NO LOG DATA" : data
  end
end

