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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  token_balance          :integer
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
