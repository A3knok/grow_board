class Post < ApplicationRecord
	validates :name, presence: true
  validates :body, presence: true

	GROWTH_STAGE = [	
		{ range: 0..9, image: "tree_seed.png", name: "種" },
		{ range: 10..19, image: "tree_small.png", name: "苗" },
		{ range: 20..29, image: "tree_middle.png", name: "若木" },
		{ range: 30..39, image: "tree_large.png", name: "成木" },
		{ range: 40..49, image: "tree_extra_large.png", name: "収穫" }
	]

	def self.growth_info
		post_count = count
		cycle_count = post_count % 50

		current_stage = GROWTH_STAGE.find{ |stage|
			stage[:range].include?(cycle_count)
		}

		#:rangeの最小値がcycle_countより大きい最初のハッシュを見つけてnext_stageへ代入
		next_stage = GROWTH_STAGE.find{ |stage|
			stage[:range].first > cycle_count
		}

		remaining_posts = if next_stage
			next_stage[:range].first - cycle_count		
		else
			50 - cycle_count
		end

		{
			post_count: post_count,
			# current_imageから:imageを取り出す
			# 値が無ければ(nil)tree_seed.pngを使用
			base_image: current_stage&.dig(:image) || "tree_seed.png",
			stage_name: current_stage&.dig(:name) || "種",
			remaining_posts: remaining_posts
		}
	end
end
