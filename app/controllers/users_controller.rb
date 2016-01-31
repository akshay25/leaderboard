class UsersController < ApplicationController

	def create
		user = User.new(params)
		if user.save
			response_formatter({user_id: user.id, user_name: user.name}, {message: 'User succesfully created'}, 200)
		else
			response_formatter(user.errors, {message: 'User creation failed'}, 400)
		end
	end

	def update
		user = User.find(params[:id])
		if user.present?
			user.update_attributes(params)
			response_formatter({user_id: user.id, user_name: user.name}, {message: 'User succesfully updated'}, 200)
		else
			response_formatter(user.errors, {message: 'User update failed'}, 400)
		end
	end
	
	def show 
		user = User.find(params[:id])
		if user.present?
			response_formatter(user.attributes, {message: 'user info'}, 200)
		else
			response_formatter({}, 'user not found', 400)
		end
	end

	def index
		users = User.all.collect do |user|
			user.attributes.except('created_at', 'updated_at')
		end	
		response_formatter({users: users}, {message: 'All users profile'}, 200)
	end

end
