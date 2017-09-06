require 'net/http'

class Repo::GitHub < Repo

  validates :json_url  , uniqueness: true, presence: true
  validates :name      , uniqueness: true, presence: true

  before_validation :set_url

  hstore_accessor :xfields, :etag => :string

  validates :name, format: { with:    /\A[\_\-\.a-zA-Z0-9]+\/[\.\_\-a-zA-Z0-9]+\z/,
                             message: "needs GitHub repo '<user>/<repo>'" }

  validate :repo_url_presence

  private

  def set_url
    self.html_url = "https://github.com/#{self.name}/issues"
    self.json_url = "https://api.github.com/repos/#{self.name}/issues"
  end

  def repo_url_presence
    repo = Octokit.repo(self.name)
    return if repo.present?
    errors.add :name, "GitHub repo does not exist"
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
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
