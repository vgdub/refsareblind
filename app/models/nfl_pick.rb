class NflPick < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :user
	belongs_to :pool
	belongs_to :pool_user
	belongs_to :nfl_team
	belongs_to :nfl_matchup

# VALIDATIONS

# SPECIAL FEATURES

# SCOPES

# DELEGATIONS

# CALLBACKS

# CONFIG METHODS
	def to_s
		self.nfl_team
	end

	def to_param
	end

# CLASS METHODS

# INSTANCE METHODS
	def score_pick(winning_team)
		if winning_team == "tie"
			self.update_attributes(result: "tie")
		elsif winning_team == self.nfl_team_id
			self.update_attributes(result: "win")
		elsif winning_team && winning_team != self.nfl_team_id
			self.update_attributes(result: "loss")
		end
	end

# PRIVATE METHODS
private
end
