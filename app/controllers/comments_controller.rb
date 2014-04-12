class CommentsController < ApplicationController

	def create
        # When an issue is created 
        @comment = Comment.create(params[:comment])

        respond_to do |format|
            if @comment.save
                format.html { redirect_to :back, notice: 'Comment was successfully created.' }
                format.json { head :no_content }
            else
                format.html { render :action => 'new', alert: 'Comment was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
   	end
end
