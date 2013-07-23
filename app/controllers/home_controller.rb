# coding: utf-8
class HomeController < ApplicationController

  # 首页
  def index
    resp=shiyi_conn.get '/api/v2/brand/list'
    @result = ActiveSupport::JSON.decode(resp.body)

  end
  # 品牌下的商品列表
  def list
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
    @id = params[:id]
    resp=shiyi_conn.get '/api/v2/goods/brand_list',{:brand_id=>@id,:page=>@page,:per_page => 14,:is_wifi=>false}
    @goods_list=ActiveSupport::JSON.decode(resp.body)

    @ids = ''

    @goods_list.each do|goods|
      @ids << goods['id'].to_s+' '
    end

    #@brand_list = Crack::JSON.parse(resp.body)

  end

  # 商品详情
  def detail
    @ids = params[:ids].split
    @current_id = params[:id]
    resp=shiyi_conn.get '/api/v2/goods/detail',{:id=>params[:id],:is_wifi=>false}
    @goods=ActiveSupport::JSON.decode(resp.body)
  end

  def next
    p params[:id]
    resp=shiyi_conn.get '/api/v2/goods/detail',{:id=>params[:id] || 946,:is_wifi=>false}
    respond_to do |format|
      format.html
      format.json{
        render :json => ActiveSupport::JSON.decode(resp.body)
      }
    end
  end

  def simple_order

    resp=shiyi_conn.get '/api/v2/order/simple_order',{:goods_id=>params[:goods_id],:mobile=>params[:mobile]}
    @result=ActiveSupport::JSON.decode(resp.body)

  end

end
