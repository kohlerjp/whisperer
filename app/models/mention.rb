class Mention < ActiveRecord::Base
	belongs_to :user, foreign_key: :uid
	belongs_to :post
end
