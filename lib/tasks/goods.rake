#encoding:utf-8
namespace :goods do
  def conn
    conn = Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
                                   #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    conn
  end

  desc '获取全部goods id'

  task :get do
    #ids2 = ids
    #ids = []
    #get_ids.each do |k,v|
    #  ids << k.to_i
    #end
    ids = [240,217, 229,245,235, 238, 236, 221, 237,242, 239, 232, 241, 233]
    arr = []
    ids.each do |id|
      page = 1
      p id
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
    p '====='
    p arr
  end

end


