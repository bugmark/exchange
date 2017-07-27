class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

  def to_i
    self.id
  end

  # ----- ASSOCIATIONS -----

  def published_contracts
    Contract.where(publisher_id: self.id)
  end

  def taken_contracts
    Contract.where(counterparty_id: self.id)
  end

  # ----- ACCOUNT -----

  def ether_balance
    0
  end

  private

  def default_values
    self.pokerbux_balance ||= 100
  end
end
