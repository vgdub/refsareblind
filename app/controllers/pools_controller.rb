class PoolsController < ApplicationController

	def index
		@pools = Pool.public
	end

end
