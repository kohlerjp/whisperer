class PostsController < ApplicationController

	def create
    @post = current_user.posts.build(micropost_params)
    
    if @post.save
         mention = Mention.new(uid: params[:post][:mentioned],post_id: params[:post_id] )
         mention.save
        redirect_to @post
    else
      redirect_to root_url
    end
  end

  def show
    @post = Post.find params[:id]
  end
  def new
    @graph = Koala::Facebook::API.new(current_user.oauth_token) 
    @profile = @graph.get_object("me")
    @post = current_user.posts.build
  end

  def destroy
    @post = Post.find params[:id]
    mentions = Mention.where(post_id:@post.id)
    mentions.each do |mention|
      mention.destroy
    end
    @post.destroy
    redirect_to current_user
  end


  private

  	def micropost_params

  		params.require(:post).permit(:text)
  	end
end
