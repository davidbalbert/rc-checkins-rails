class GroupsController < ApplicationController
	def index
		if !session[:current_user].nil?
			@groups = Group.order("available_time_id DESC, room ASC")
			# @groups = Group.all
		else
			redirect_to '/login'
		end
	end

	def new
		@group = Group.new
		@available_times = AvailableTime.all
	end


	def create
		@group = Group.new(group_params)

		if @group.save
			redirect_to "/"
		else
			render 'new'
		end
	end

	def update
		@group = Group.find(params[:id])
		@group.update(group_params)

		redirect_to "/"
		#error handling!
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to "/"
	end


	private
		def group_params
			params.require(:group).permit(:room, :time, :topic, :available_time_id)
		end
end
