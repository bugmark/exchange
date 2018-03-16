class ContractQuery
  include ActiveModel::Model

  attr_accessor :readme_qry, :language_qry

  def search
    return Contract.all if readme_qry.blank? && language_qry.blank?
  end
end