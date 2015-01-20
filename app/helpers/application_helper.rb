module ApplicationHelper
  def fix_url(string)
    string.starts_with?("http://") ? string : "http://#{string}"
  end

  def pretty_date(string)
    string.strftime("%a %b #{string.day.ordinalize} %Y %H:%M:%S #{string.zone}") 
  end
end
