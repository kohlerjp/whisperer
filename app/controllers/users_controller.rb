class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@graph = Koala::Facebook::API.new(@user.oauth_token) 
		@profile = @graph.get_object("me")
		@post = current_user.posts.build
	end

	def index
		@users = User.all
		respond_to do |format|
			format.json { render :json => @users }
		end
	end

	def friends
		@user = User.find(params[:id])
		@graph = Koala::Facebook::API.new(@user.oauth_token) 
		@friends = @graph.get_connections("me", "friends")
		@friends.each do |friend|
			 friend[:image]= "http://graph.facebook.com/#{friend['id']}/picture?height=100&width=100"
		end
		respond_to do |format|
			format.json { render :json => @friends }
		end
	end
end
