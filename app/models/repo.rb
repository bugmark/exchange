require 'net/http'
require 'uri'

class Repo < ApplicationRecord

  has_many :bugs         , :dependent => :destroy
  has_many :contracts    , :dependent => :destroy
  has_many :bug_contracts, :through   => :bugs    , :source => :contracts

  validates :url  , uniqueness: true, presence: true
  validates :name , uniqueness: true, presence: true

  def sync
    self.update_attribute(:synced_at, Time.now)
    json = open(self.url) {|io| io.read}
    JSON.parse(json).each do |el|
      attrs = {
        repo_id:   self.id         ,
        type:      "Bug::GitHub"   ,
        api_url:   el["url"]       ,
        http_url:  el["http_url"]  ,
        title:     el["title"]     ,
        labels:    el["labels"]    ,
        status:    el["state"]     ,
        synced_at: Time.now
      }
      bug = Bug.find_or_create_by(exref: el["id"])
      bug.update_attributes(attrs)
    end
  end

  # ----- SCOPES -----

  class << self
    def github
      where(type: "Repo::GitHub")
    end
  end
end

# == Schema Information
#
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  url        :string
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
