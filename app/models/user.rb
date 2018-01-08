class User < ApplicationRecord

  has_paper_trail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  before_save :default_values

  with_options foreign_key: "user_uuid", primary_key: "uuid" do
    has_many :offers     , class_name: "Offer"
    has_many :offers_buy , class_name: "Offer::Buy"
    has_many :offers_bu  , class_name: "Offer::Buy::Unfixed"
    has_many :offers_bf  , class_name: "Offer::Buy::Fixed"
    has_many :offers_sell, class_name: "Offer::Sell"
    has_many :offers_su  , class_name: "Offer::Sell::Unfixed"
    has_many :offers_sf  , class_name: "Offer::Sell::Fixed"
    has_many :positions
  end

  jsonb_accessor :jfields, :last_session_ended_at => :datetime

  validates_uniqueness_of :email

  validates :email    , :presence => true
  validates :password , :presence => true, :on => :create, unless: :has_encrypted_pwd?
  validates :balance  , :numericality => { greater_than_or_equal_to: 0.0 }

  def event_lines
    Event.for_user(self.id)
  end

  def last_event_at
    return nil if event_lines.count == 0
    event_lines.order('id desc').limit(1).first.created_at
  end

  def new_event_lines
    event_lines.where('created_at > ?', self.last_session_ended_at).order('id desc') #.
  end



  def xtag
    "usr"
  end

  def sname
    self.email.split("@").first.capitalize
  end

  def contracts
    positions.map(&:contract).flatten.uniq.sort_by {|c| c.uuid}
  end

  # ----- ACCOUNT BALANCES AND RESERVES-----

  def token_reserve_poolable
    offers.is_buy.open.poolable.map(&:value).max || 0.0
  end

  def token_reserve_not_poolable
    offers.is_buy.open.not_poolable.map(&:value).sum || 0.0
  end

  def token_reserve
    result = token_reserve_poolable + token_reserve_not_poolable
    result.round(2)
  end

  def token_available
    (balance - token_reserve).round(2)
  end

  # ----- SCOPES -----

  class << self
    def demo_accounts
      qry = %w(joe jane test).map {|x| "email ilike '#{x}%'"}.join(" OR ")
      where(qry).order('email asc')
    end

    def low_balance
      where('balance < 100')
    end

    def select_subset
      select(%i(id uuid email balance))
    end
    alias_method :ss, :select_subset
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
    # self.balance = 1000.0 if self.balance.zero?
    # self.balance ||= 1000
  end

  def has_encrypted_pwd?
    self.encrypted_password.present?
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  uuid                   :string
#  exid                   :string
#  admin                  :boolean
#  auth_token             :string
#  balance                :float            default(0.0)
#  jfields                :jsonb            not null
#  last_seen_at           :datetime
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
