class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

	def new
		@project = Project.new
	end

	def create
        @project = Project.create(params[:project])

        respond_to do |format|
            if @project.save
                format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Project was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])

        respond_to do |format|
            if @project.update_attributes(params[:project])
                format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'edit', alert: 'Project was unsuccessfully updated.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
	end

	def destroy
        @project = Project.find(params[:id])
        @project.destroy
        redirect_to :back
    end

end
