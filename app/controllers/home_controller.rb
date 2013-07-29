# coding: utf-8
class HomeController < ApplicationController

  # 首页
  def index
    # 清楚 商品ids
  end

  # 品牌下的商品列表
  def list
    # 页码
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
    # 品牌id
    @id = params[:id]
    # id空 重定向
    if @id.blank?
      redirect_to(:action => 'index')
    end
    resp=shiyi_conn.get '/api/v2/goods/brand_list', {:brand_id => @id, :page => @page, :per_page => 14, :is_wifi => false}
    @goods_list=ActiveSupport::JSON.decode(resp.body)

    if @goods_list.present? and @goods_list.length >= 1
      set_seo_meta(@goods_list[0]['brand_name'])
    end

    #ids = []
    #@goods_list.each do |goods|
    #  ids << goods['id'].to_i
    #end
    #
    #session[:ids] = ids

  end

  # 商品详情
  def detail

    # 当前商品id
    @current_id = params[:id]
    resp=shiyi_conn2.get '/api/v2/goods/detail', {:id => params[:id], :is_wifi => true}
    @goods=ActiveSupport::JSON.decode(resp.body)

    if @goods.present?
      set_seo_meta(@goods['name'])
    end

    # 获取下/上一个商品的 id

    @pre_id = get_pre_goods_id(@current_id)
    @next_id = get_next_goods_id(@current_id)

    #p 'pre_id='+ @pre_id.to_s
    #p 'next_id='+ @next_id.to_s
    # 品牌id
    #brand_id = params[:brand_id]
    #page = params[:page]

  end

  def next
    p params[:id]
    resp=shiyi_conn3.get '/api/v2/goods/detail', {:id => params[:id] || 946, :is_wifi => false}
    respond_to do |format|
      format.html
      format.json {
        render :json => ActiveSupport::JSON.decode(resp.body)
      }
    end
  end

  def order
    @id = params[:id]
    resp = shiyi_conn2.get '/api/v2/goods/detail', {:id => params[:id], :is_wifi => false}
    goods = ActiveSupport::JSON.decode(resp.body)
    if goods
      @color = Array.new;
      @measure = Array.new;
      goods["sku"].each_with_index do |sku, index|
        if sku["color"].include?("-")
          @color.push(sku["color"].split('-')[0])
        else
          @color.push(sku["color"])
        end
        if sku["measure"] && (index == 1)
          sku["measure"].each do |measure|
            @measure.push(measure["size"])
          end
        end
      end
    end
  end

  def confirm
    #shiyi_conn4 = Faraday.new(:url => 'http://192.168.1.188:3000') do |faraday|
    #  faraday.request :multipart
    #  faraday.request  :url_encoded             # form-encode POST params
    #                                            #faraday.response :logger                  # log requests to STDOUT
    #  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    #end

    # TODO 手机号码验证
    #params[:goods_id] = '735'
    #params[:mobile] = '13958025410'
    resp=shiyi_conn4.post '/api/v2/order/simple_order', {:goods_id => params[:goods_id], :mobile => params[:mobile]}
    @result=ActiveSupport::JSON.decode(resp.body)
    p @result

    render :json => @result

  end

end
