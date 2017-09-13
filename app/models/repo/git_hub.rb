class Repo::GitHub < Repo

  validates :name, uniqueness: true, presence: true
  validates :name, format: { with:    /\A[\_\-\.a-zA-Z0-9]+\/[\.\_\-a-zA-Z0-9]+\z/,
                             message: "needs GitHub repo '<user>/<repo>'" }

  validate :repo_presence

  def html_url
    "https://github.com/#{self.name}"
  end

  private

  def repo_presence
    repo = Octokit.repo(self.name)
    return if repo.present?
    errors.add :name, "GitHub repo does not exist"
  end
end
