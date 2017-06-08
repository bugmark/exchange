module ApplicationHelper

  def nav_link(label, path)

    ext1, ext2 = if current_page?(path) then
      ["active", '<span class="sr-only">(current)</span>']
    else
      ["", ""]
    end

    raw %{
      <li class="nav-item #{ext1}">
        <a class="nav-link" href="#{path}">#{label} #{ext2}</a>
      </li>
    }
  end

end
