class PostsController < ApplicationController
  before_action :signed_in_user
  before_filter :set_access

def set_access
  @response.headers["Access-Control-Allow-Origin"] = "*"
end
	def create
    @post = current_user.posts.build(micropost_params)
    text = @post.text
    mention_ids = text.scan(/@[^ \t]*/)
   

    if @post.save
          mention_ids.each do |user_id|
      user_id = user_id.delete('@')
      mention = Mention.new(uid: user_id, post_id: @post.id )
      mention.save

    end
          redirect_to @post
    else
      redirect_to @post
    end
  end

  def show
    @post = Post.find params[:id]
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
