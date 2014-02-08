class GenericPagesController < ApplicationController
	def home
		if current_user
		 @graph = Koala::Facebook::API.new(current_user.oauth_token) 

		 @rest = Koala::Facebook::API.new(current_user.oauth_token)
		end
		 


	end
	def index
		if current_user
			redirect_to home_path
		end
	end
end
