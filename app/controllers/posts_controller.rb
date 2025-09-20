class PostsController < ApplicationController
	def index
		@posts = Post.order(created_at: :desc).limit(4)
		@post = Post.new
		set_growth_data
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to posts_path, success: '実らせました'
		else
			@posts = Post.order(created_at: :desc).limit(4)
			set_growth_data
			flash.now[:danger] = '入力が不足しています'
			render :index, status: :unprocessable_entity
		end
	end

	private

	def post_params
		params.require(:post).permit(:name, :body)
	end

	def set_growth_data
			growth_data = Post.growth_info
			@post_count = growth_data[:post_count]
			@base_image = growth_data[:base_image]
			@stage_name = growth_data[:stage_name]
			@remaining_posts = growth_data[:remaining_posts]
	end
end
