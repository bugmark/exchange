require 'net/http'
require 'uri'

class Repo < ApplicationRecord

  has_many :bugs         , :dependent => :destroy
  has_many :contracts    , :dependent => :destroy
  has_many :bug_contracts, :through   => :bugs    , :source => :contracts

  validates :json_url , uniqueness: true, presence: true
  validates :name     , uniqueness: true, presence: true

  def xid
    "rep.#{self.id}"
  end

  def xtype
    self.type.gsub("Repo::","")
  end

  def has_contracts?
    contracts.count != 0 || bug_contracts.count != 0
  end

  def sync
    self.update_attribute(:synced_at, Time.now)
    json = open(self.json_url) {|io| io.read}
    JSON.parse(json).each do |el|
      attrs = {
        repo_id:   self.id         ,
        type:      "Bug::GitHub"   ,
        json_url:  el["url"]       ,
        html_url:  el["html_url"]  ,
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
#  json_url   :string
#  html_url   :string
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
