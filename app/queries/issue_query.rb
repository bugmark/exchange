class IssueQuery
  include ActiveModel::Model

  attr_accessor :comment_qry, :language_qry, :offer_qry

  def search
    case
      when comment_qry.blank? && language_qry.blank?
        Bug.all
      when comment_qry.present? && language_qry.blank?
        Bug.comment_search(comment_qry)
      when comment_qry.blank? && language_qry.present?
        Bug.language_search(language_qry)
      else
        Bug.combined_search(language_qry + " " + comment_qry)
    end
  end
end

