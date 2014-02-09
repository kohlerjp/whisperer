include ActionView::Helpers
class Post < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	belongs_to :user
	has_many :mentions
	has_many :mentioned_users, through: :mentions, source: :user

	validates :text, presence: true, length: {maximum:130}
	attr_accessor :mentioned

	  def as_json(options={})
  		{ :text => self.text, :sentiment => self.sentiment, :mentioned => self.mentions.first.uid, :created_at => time_ago_in_words(self.created_at)}
	end




end
