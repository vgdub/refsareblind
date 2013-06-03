class PoolUser < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :pool
	belongs_to :user
	has_many :nfl_picks

# VALIDATIONS

# SPECIAL FEATURES

# SCOPES

# DELEGATIONS

# CALLBACKS

# CONFIG METHODS
	def to_s
		"#{self.name} - #{self.user}"
	end

	def to_param
	end

# CLASS METHODS

# INSTANCE METHODS
def nfl_teams_used
	NflTeam.joins(:nfl_picks).where("pool_id = ? AND user_id = ? AND locked IS true", self.pool_id, self.user_id)
end

def eliminated?
	NflPick.where("pool_id = ? AND user_id = ?", self.pool_id, self.user_id).pluck(:result).include?("loss") ? true : false ;
end

def total_score
	NflPick.where("pool_id = ? AND user_id = ? AND result = 'win'", self.pool_id, self.user_id).count + (NflPick.where("pool_id = ? AND user_id = ? AND result = 'tie'", self.pool_id, self.user_id).count / 2.0)
end

def weekly_picks(week)
	NflPick.joins(:nfl_matchup).where("pool_id = ? AND user_id = ? AND week = ? AND locked IS true", self.pool_id, self.user_id, week)
end

# PRIVATE METHODS
private

end
