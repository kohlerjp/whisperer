class Post < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	belongs_to :user
	has_many :mentions
	has_many :mentioned_users, through: :mentions, source: :user
end
