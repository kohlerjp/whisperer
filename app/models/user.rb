class User < ActiveRecord::Base
  self.primary_key = :uid
  has_many :posts
  has_many :mentions, foreign_key: :uid
  has_many :mentioned_posts, through: :mentions, source: :post, foreign_key: :uid


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end