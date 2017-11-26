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

  def qscore(free_qry, lang_qry)
    qs = []
    # qs << rank_str("'id'||id"             , free_qry  ) if free_qry
    # qs << rank_str("'repo'||stm_repo_id"  , free_qry  ) if free_qry
    qs << rank_str("stm_title"            , free_qry  ) if free_qry
    qs << rank_str("stm_labels"           , free_qry  ) if free_qry
    # qs << rank_str("stm_jfields->'comments'"  , free_qry  ) if free_qry
    # qs << rank_str("xfields->'languages'" , lang_qry  ) if lang_qry
    rank = qs.join(" + ")
    Bug.joins(:repo).where("#{rank} > 0").order("#{rank} desc")
    Bug.joins(:repo)
  end

  def join_str(field, qry)
  "ts_rank(to_tsvector('english', #{field}),  plainto_tsquery('english', '#{qry}'))"
  end

  def rank_str(field, qry)
    "ts_rank(to_tsvector('english', #{field}),  plainto_tsquery('english', '#{qry}'))"
  end
end
