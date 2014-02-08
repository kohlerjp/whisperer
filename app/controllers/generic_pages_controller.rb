class GenericPagesController < ApplicationController
	def home
		 @graph = Koala::Facebook::API.new(current_user.oauth_token) 

		 @rest = Koala::Facebook::API.new(current_user.oauth_token)
		 


	end
end
