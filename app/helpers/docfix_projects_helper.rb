module DocfixProjectsHelper

  def docfix_readme_text(project)
    raw project.readme_txt.gsub("\n", "<br/>")
  end
end
