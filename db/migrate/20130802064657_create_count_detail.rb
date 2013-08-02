class CreateCountDetail < ActiveRecord::Migration
  def change
    create_table :count_details do |t|
      t.integer  :goods_id ,  comment: '品牌id', :default => false
      t.string   :ip       ,  comment: 'ip'
      t.boolean  :direct   ,  comment: 'true:直接列表点击的  false:上一页 下一页点击'
      t.datetime :created_at
    end
  end
end
