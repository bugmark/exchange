module DocfixProjectsHelper

  def docfix_readme_text(project)
    text = project.readme_txt.gsub("\n", "<br/>")
    text.length < 400 ? raw(text) : raw(text[0..400] + "...")

  end
end
