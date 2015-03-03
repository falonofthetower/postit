module ApplicationHelper
  def fix_url(string)
    string.starts_with?("http://") ? string : "http://#{string}"
  end

  def pretty_date(string)
    if logged_in? && !current_user.time_zone.blank?
      string = string.in_time_zone current_user.time_zone
    end

    string.strftime("%a %b #{string.day.ordinalize} %Y %H:%M:%S #{string.zone}") 
  end
end
