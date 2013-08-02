class CreateCountList < ActiveRecord::Migration
  def change
    create_table :count_lists do |t|
      t.integer  :brand_id ,  comment: '品牌id', :default => false
      t.string   :ip       ,  comment: 'ip'
      t.datetime :created_at
    end
  end
end
