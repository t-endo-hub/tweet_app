class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: @user.id)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render 'users/edit'
		end
	end

	def destroy
		user = User.find(params[:id])
		if user.delete
			redirect_to users_path
		end
	end

	def search
		if params[:name].present?
			@users = User.where('name LIKE ?', "%#{params[:name]}%")
		else
			@users = User.none
		end
	end


end

private

def user_params
	params.require(:user).permit(:name, :email)
end
