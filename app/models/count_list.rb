class Contact < ActiveRecord::Base
  attr_accessible :owner_mobile, :contact_id, :mobile, :name
end
