class PostController < ApplicationController
    def index
        growth_data = Post.growth_info

        @post_count = growth_data[:post_count]
        @base_image = growth_data[:base_image]
        @stage_name = growth_data[:stage_name]

        @post = Post.new
    end
end
