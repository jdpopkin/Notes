module ApplicationHelper

  def escape_html(str)
    str = str.gsub("<", "")
    str = str.gsub("&", "+")
  end
end
