class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
		@user = User.find_by(id: @post.user_id)
	end

	def edit
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		post = Post.new(post_params)
		post.user_id = current_user.id
		if post.save
			redirect_to posts_path
		else
			render new_post_path
		end
	end


	def edit
		@post = Post.find(params[:id])
	end

	def update
		post = Post.find(params[:id])
		if post.update(post_params)
			redirect_to posts_path
		else
			render edit_post_path(post)
		end
	end

	def destroy
		post = Post.find(params[:id])
		if post.delete
			redirect_to posts_path
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :image)
	end
end
