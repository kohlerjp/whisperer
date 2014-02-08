class PostsController < ApplicationController
	def create
    @post = current_user.posts.build(micropost_params)
    if @post.save
      redirect_to current_user
    else
    end
  end

  private

  	def micropost_params

  		params.require(:post).permit(:text)
  	end
end
