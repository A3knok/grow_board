class PostController < ApplicationController
    def index
        @post_count = Post.count
        cycle_count = @post_count % 100

        
        base_image = calculate_tree_image(cycle_count)
        @tree_image = base_image
    end

    private

    def calculate_tree_image(cycle_count)
        case cycle_count
        when 0..9
            "tree_seed.png"
        when 10..19
            "tree_small.png"
        when 20..59
            "tree_middle.png"
        when 60..99
            "tree_big.png"
        end
    end
end
