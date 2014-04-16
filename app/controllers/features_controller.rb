class FeaturesController < ApplicationController
    before_filter :authenticate_user!, :except => :index

	def index
		@users = User.all
		@user = current_user
		if params[:project_id].present?
			@project = Project.find(params[:project_id])
      @storyboards = @project.discussions.storyboards.recent.popular

		end
	end

	def show
		@project = Project.find(params[:project_id])
		@storyboard = Discussion.find(params[:id])
		@comments = @storyboard.comments
	end

	def new
		@project = Project.find(params[:project_id])
		@storyboard = @project.discussions.new
	end

	def create
        # When an storyboard is created 
        @project = Project.find(params[:project_id])
        @storyboard = @project.discussions.create(params[:feature])

        respond_to do |format|
        	if @storyboard.save
        		format.html { redirect_to :back, notice: 'Storyboard was successfully created.' }
        		format.json { head :no_content }
        	else
        		format.html { render :action => 'new', alert: 'Storyboard was unsuccessfully created.' }
        		format.json { render json: @message.errors, status: :unprocessable_entity }
        	end 
        end
    end

    def edit
    	@storyboard = Discussion.find(params[:id])
    end

    def update
    	@storyboard = Discussion.find(params[:id])

    	respond_to do |format|
    		if @storyboard.update_attributes(params[:discussion])
    			format.html { redirect_to project_path(@project), notice: 'Storyboard was successfully updated.' }
    			format.json { head :no_content }
    		else
    			format.html { render :action => 'edit', alert: 'Storyboard was unsuccessfully updated.' }
    			format.json { render json: @message.errors, status: :unprocessable_entity }
    		end 
    	end
    end 

    def up_vote
    	@storyboard = Discussion.find(params[:id])
    	@storyboard.up_vote
    	redirect_to :back
    end

    def down_vote
    	@storyboard = Discussion.find(params[:id])
    	@storyboard.down_vote
    	redirect_to :back
    end

    def destroy
    	@storyboard = Discussion.find(params[:id])
    	@storyboard.destroy
    	redirect_to :back
    end

end
