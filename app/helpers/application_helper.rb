#encoding:utf-8
module ApplicationHelper

  # 首页上展示的品牌 ids
  def get_brand
    array={
        #'240'=>%w[,COCO DEA 可可迪尔],

        '217'=>['2.jpg', 'five plus'],
        '229'=>['13.jpg', 'GOELIA 歌莉娅'],
        #'148'=>['9.jpg', 'H&M'],
        '235'=>['8.jpg', 'LILY'],

        '238'=>['5.jpg', 'MANGO'],
        '236'=>['4.jpg', 'MS 玛莎'],
        '221'=>['7.jpg', 'OCHIRLY 欧时力'],
        '237'=>['6.jpg', 'ONLY'],

        '75'=>['1.jpg', 'UNIQLO 优衣库'],
        '239'=>['10.jpg', 'VERO MODA'],
        '232'=>['11.jpg', 'ZARA'],
        '241'=>['8.jpg', 'EIFINI 伊芙丽'],

        '233'=>['3.jpg', 'NOIHSAF 诺诗凡']
    }
  end

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
