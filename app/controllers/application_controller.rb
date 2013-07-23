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
    array = []
    array << 237
    array << 238
    array << 240
    array << 232
    array << 217
    array << 239
    array << 236
    array << 239
    array << 221
    array << 148
    array << 235
    array << 75
    array << 218
    array << 215

    id
  end
end
