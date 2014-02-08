class PostsController < ApplicationController
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
      redirect_to current_user
    else
    end
  end

  def show
    @post = Post.find params[:id]
  end

  private

  	def micropost_params

  		params.require(:post).permit(:text)
  	end
end
