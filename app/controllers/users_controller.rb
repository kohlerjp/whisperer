class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@graph = Koala::Facebook::API.new(current_user.oauth_token) 
		@profile = @graph.get_object("me")
		@post = current_user.posts.build
	end

	def index
		@users = User.all
	end
end
