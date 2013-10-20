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

	end

	def edit
		@project = Project.find(params[:id])
	end

	def update

	end
end
