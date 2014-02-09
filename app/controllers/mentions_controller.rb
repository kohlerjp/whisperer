class MentionsController < ApplicationController

	def index
		@men = Mention.all
	respond_to do |format|
      format.json { render :json => @men }
   	 end
	end
end
