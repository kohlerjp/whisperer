class PostsController < ApplicationController
  require 'open-uri'
require 'json'

	def create
    @post = current_user.posts.build(micropost_params)
    safe_text = params[:post][:text].gsub(/\s/,'%20')
    response = HTTParty.get("http://api.datumbox.com/1.0/SentimentAnalysis.json?api_key=a58c154d6ab8e1b4a0d69590668591d7&text=#{safe_text}")
    body = JSON.parse(response.body)
    result = body["output"]["result"]
    @post.sentiment = result
      

    
    if @post.save
      myid = params[:post][:mentioned]
         mention = Mention.new(uid: myid,post_id: @post.id )
         mention.save
        redirect_to @post
    else
      redirect_to root_url
    end
  end

  def show
    @post = Post.find params[:id]
    @rest = Koala::Facebook::API.new(current_user.oauth_token)
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
  def index
    @posts = Post.all
    @posts.each do |p|
      p.mentioned = p.mentions.first.uid
    end

     respond_to do |format|
      format.json do
        render :json => @posts.to_json(except: :user_id, :include => { :mentions => { :only => :uid } })
      end
    end
    
  end


  private



    def mention_params
      params.require(:post).permit(:mentioned)
    end

  	def micropost_params

  		params.require(:post).permit(:text)
  	end
end
