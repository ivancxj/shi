module ApplicationHelper

  def controller_stylesheet_link_tag
    # 还未做好
    #case controller_name
    #  when "users","home", "topics", "pages", "search", "sites", "notifications", "notes"
    #    stylesheet_link_tag controller_name
    #  when "replies"
    #    stylesheet_link_tag "topics"
    #end
  end

  def controller_javascript_include_tag
    # 还未做好
    #case controller_name
    #  when "pages","topics","sites", "notifications", "notes"
    #    javascript_include_tag controller_name
    #  when "replies"
    #    javascript_include_tag "topics"
    #end
  end

  def render_page_title
    site_name = Setting.app_name
    title = @page_title ? "#{@page_title}-#{site_name}" : site_name
    content_tag('title', title, nil, false)
  end

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
      'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
      'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
      'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
      'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end
end
