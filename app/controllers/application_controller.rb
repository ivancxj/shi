class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def notice_success(msg)
    flash[:notice] = msg
  end

  def notice_error(msg)
    flash[:notice] = msg
  end

  def notice_warning(msg)
    flash[:notice] = msg
  end

  def set_seo_meta(title = '',meta_keywords = '', meta_description = '')
    if title.length > 0
      @page_title = "#{title}"
    end
    @meta_keywords = meta_keywords
    @meta_description = meta_description
  end


  def shiyi_conn
    @@shiyi_conn ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn2
    @@shiyi_conn2 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn3
    @@shiyi_conn3 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn4
    @@shiyi_conn4 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_pre_brand(id)

    1
  end

  def get_next_brand (id)


    2
  end

end
