class IssueQuery
  include ActiveModel::Model

  attr_accessor :free_qry, :lang_qry, :offer_qry

  def search
    if free_qry.blank? && lang_qry.blank?
      Bug.all
    else
      qscore(free_qry, lang_qry)
    end
  end

  private

  def qscore(freq, lanq)
    qs = []
    qs << rank_str("'id'||bugs.id"             , freq) if freq.present?
    qs << rank_str("'repo'||stm_repo_id"       , freq) if freq.present?
    qs << rank_str("stm_title"                 , freq) if freq.present?
    qs << rank_str("stm_labels"                , freq) if freq.present?
    qs << rank_str("stm_jfields->'comments'"   , freq) if freq.present?
    qs << rank_str("repos.xfields->'languages'", lanq) if lanq.present?
    rank = qs.join(" + ")
    # slst = ["repos.xfields->'languages' as lang", "bugs.*"]
    # Bug.joins(:repo).select(*slst).where("#{rank} > 0").order("#{rank} desc")
    Bug.joins(:repo).where("#{rank} > 0").order("#{rank} desc")
  end

  def rank_str(field, qry)
    "ts_rank(to_tsvector('english', #{field}),  plainto_tsquery('english', '#{qry}'))"
  end
end
