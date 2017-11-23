class ProjectQuery
  include ActiveModel::Model

  attr_accessor :readme_qry, :language_qry

  def search
    case
      when readme_qry.blank? && language_qry.blank?
        Repo.all
      when readme_qry.present? && language_qry.blank?
        Repo.readme_search(readme_qry)
      when readme_qry.blank? && language_qry.present?
        Repo.language_search(language_qry)
      else
        Repo.combined_search(language_qry + " " + readme_qry)
    end
  end
end