class StaticController < ApplicationController

  layout 'home'

  def home
  end

  def experiments
  end

  def help
  end

  def test
  end

  def chart
  end

  def data
    render plain: File.read("#{File.dirname(__FILE__)}/data.text")
  end

  def mailpost
    @address = save_address(params["mail_addr"])
    flash[:notice] = " Thanks for joining the BugMark mailing list! (#{@address})"
    redirect_to "/static/home"
  end

  private

  def save_address(addr)
    addr_file = Rails.root.join("log", "mail_#{Rails.env}.txt").to_s
    tstamp    = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
    File.open(addr_file, 'a') do |f|
      f.puts "#{tstamp},#{addr}"
    end
    addr
  end
end

