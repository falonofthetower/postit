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

  def path_to_vote(obj, boolean)
    if obj.instance_of? Comment
      vote_post_comment_path(obj.post, obj, vote: boolean)
    elsif obj.instance_of? Post
      vote_post_path(obj, vote: boolean)
    end
  end
end
