#encoding:utf-8
require 'index_brand'
namespace :goods do
  def conn
    conn = Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
                                   #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    conn
  end

  desc '获取全部要显示的 goods id'

  task :all do
    arr = []
    IndexBrand.get_brand.each do |id,v|
      page = 1
      puts id
      while true do
        resp=conn.get '/api/v2/goods/brand_list', {:brand_id => id, :page => page, :is_wifi => false}
        @goods_list=ActiveSupport::JSON.decode(resp.body)
        @goods_list.each do |goods|
          arr << goods['id'].to_i
        end
        if @goods_list.blank? or @goods_list.length < 15
          break
        else
          page = page +1
        end

      end
    end

    puts '====='
    puts '数量='+arr.count.to_s
    # puts 会换行
    p arr
  end

end


