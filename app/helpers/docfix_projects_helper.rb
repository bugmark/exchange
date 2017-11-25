module DocfixProjectsHelper
  def docfix_project_readme_text(project)
    return "" if project.readme_txt.blank? || project.readme_txt.nil?
    text = project.readme_txt.gsub("\n", "<br/>")
    text.length < 400 ? raw(text) : raw(text[0..400] + "...")
  end

  def docfix_project_contracts(project)
    lbl = case (count = project.contracts.count)
      when 0 then "No Contracts"
      when 1 then "One Contract"
      else "#{count} Contracts"
    end
    raw "<h4>#{lbl}</h4>"
  end

  def docfix_project_offers(project)
    lbl = case (count = project.offers.count)
      when 0 then "No Offers"
      when 1 then "One Offer"
      else "#{count} Offers"
    end
    raw "<h4>#{lbl}</h4>"
  end
end
