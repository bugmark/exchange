class Repo < ApplicationRecord

  has_many :bugs     , :dependent => :destroy
  has_many :contracts, :dependent => :destroy

end
