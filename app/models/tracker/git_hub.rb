require 'open-uri'

class Tracker::GitHub < Tracker

  validates :name, uniqueness: true, presence: true
  validates :name, format: { with:    /\A[\_\-\.a-zA-Z0-9]+\/[\.\_\-a-zA-Z0-9]+\z/,
                             message: "needs GitHub tracker '<user>/<tracker>'" }

  hstore_accessor  :xfields , :languages  => :string
  jsonb_accessor   :jfields , :readme_url => :string
  jsonb_accessor   :jfields , :readme_txt => :string

  validate :tracker_presence

  after_create :set_languages
  after_create :set_readme

  # ----- INSTANCE METHODS

  def html_url
    "https://github.com/#{self.name}"
  end

  def readme_type
    case readme_url.split(".").last
      when "md"       then "markdown"
      when "markdown" then "markdown"
      else "text"
    end
  end

  def readme_html
    self.readme_txt
  end

  def org
    self.name.split("/").first
  end

  private

  def set_languages
    return if Rails.env.test?
    languages = Octokit.languages(self.name)
    update_attribute :languages, languages.to_hash.keys.map(&:to_s).join(", ")
  end

  def set_readme
    return if Rails.env.test?
    readme_url = Octokit.readme(self.name)[:download_url]
    return if readme_url.blank?
    update_attribute :readme_url, readme_url
    readme_txt = open(readme_url) { |io| io.read }
    update_attribute :readme_txt, readme_txt
  end

  def tracker_presence
    tracker = Octokit.repo(self.name)
    return if tracker.present?
    errors.add :name, "GitHub tracker does not exist"
  end
end

# == Schema Information
#
# Table name: trackers
#
#  id         :bigint(8)        not null, primary key
#  type       :string
#  uuid       :string
#  name       :string
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
