class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def shiyi_conn
    @@shiyi_conn ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      faraday.request :multipart
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

  # 首页上展示的品牌 ids
  def get_brand_ids
    array = [237,238,240,232,217,239,236,239,221,148,235,75,218,215]
  end
end
