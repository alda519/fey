module WallHelper

  def wall_navigation
    nav = ""
    @pages.times do |p|
     nav += '[' + (link_to_if p+1 != @current_page, "#{p + 1}", :id => p+1) +'] '
    end
    "<div class=\"navigator\">" + nav + "</div>"
  end

end
