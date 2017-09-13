class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

  has_many :bids
  has_many :asks
  has_many :bid_contracts, :through => :bids, :source => 'contract'
  has_many :ask_contracts, :through => :asks, :source => 'contract'

  def to_i
    self.id
  end

  def xid
    "usr.#{self&.id || 0}"
  end

  def contracts
    (bid_contracts + ask_contracts).uniq
  end

  # ----- ASSOCIATIONS -----

  def published_contracts
    # Contract.where(user_id: self.id)
    []
  end

  def taken_contracts
    # Contract.where(user_id: self.id)
    []
  end

  # ----- ACCOUNT -----

  def ether_balance
    0
  end

  # ----- SCOPES -----

  class << self
    def low_balance
      where('token_balance < 100')
    end
  end

  private

  def default_values
    self.token_balance ||= 100
  end
end
