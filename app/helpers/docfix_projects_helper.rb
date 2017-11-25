module DocfixProjectsHelper

  def docfix_readme_text(project)
    return "" if project.readme_txt.blank? || project.readme_txt.nil?
    text = project.readme_txt.gsub("\n", "<br/>")
    text.length < 400 ? raw(text) : raw(text[0..400] + "...")
  end
end
