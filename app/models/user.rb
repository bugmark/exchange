class User < ApplicationRecord

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

  has_many :offers     , class_name: "Offer"
  has_many :offers_buy , class_name: "Offer::Buy"
  has_many :offers_bu  , class_name: "Offer::Buy::Unfixed"
  has_many :offers_bf  , class_name: "Offer::Buy::Fixed"
  has_many :offers_sell, class_name: "Offer::Sell"
  has_many :offers_su  , class_name: "Offer::Sell::Unfixed"
  has_many :offers_sf  , class_name: "Offer::Sell::Fixed"

  has_many :positions

  def xtag
    "usr"
  end

  def contracts
    positions.map(&:contract).flatten.uniq.sort_by {|c| c.id}
  end

  # ----- ACCOUNT BALANCES AND RESERVES-----

  def token_reserve_poolable
    offers_buy.with_status("open").poolable.map(&:reserve_value).max || 0.0
  end

  def token_reserve_not_poolable
    offers_buy.with_status("open").not_poolable.map(&:reserve_value).sum || 0.0
  end

  def token_reserve
    token_reserve_poolable + token_reserve_not_poolable
  end

  def token_available
    (balance - token_reserve).round(2)
  end

  # ----- SCOPES -----

  class << self
    def low_balance
      where('balance < 100')
    end
  end

  # ----- INSTANCE METHODS -----

  def decrement(amount)
    self.balance = self.balance - amount
    self
  end

  def increment(amount)
    self.balance = self.balance + amount
    self
  end

  private

  def default_values
    self.balance ||= 100
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  balance                :float            default(0.0)
#  exref                  :string
#  uuref                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#
