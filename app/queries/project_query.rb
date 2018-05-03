class ProjectQuery
  include ActiveModel::Model

  attr_accessor :readme_qry, :language_qry

  def search
    if readme_qry.blank? && language_qry.blank?
      Tracker.all
    else
      qscore(readme_qry, language_qry)
    end
  end

  private

  def qscore(rdme_qry, lang_qry)
    qs = []
    qs << rank_str("'id'||id"                , rdme_qry) if rdme_qry.present?
    qs << rank_str("replace(name, '/', ' ')" , rdme_qry) if rdme_qry.present?
    qs << rank_str("jfields->'readme_txt'"   , rdme_qry) if rdme_qry.present?
    qs << rank_str("xfields->'languages'"    , lang_qry) if lang_qry.present?
    rank = qs.join(" + ")
    Tracker.where("#{rank} > 0").order("#{rank} desc")
  end

  def rank_str(field, qry)
    "ts_rank(to_tsvector('english', #{field}),  plainto_tsquery('english', '#{qry}'))"
  end
end