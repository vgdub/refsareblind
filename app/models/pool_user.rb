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
		self.name.present? ? "#{self.name} ( #{self.user} )" : "#{self.user}" ;
	end

	def to_param
	end

# CLASS METHODS

# INSTANCE METHODS
def nfl_teams_used
	NflTeam.joins(:nfl_picks).where("pool_user_id = ? AND locked IS true", self.id)
end

def eliminated?
	NflPick.where("pool_user_id = ?", self.id).pluck(:result).include?("loss") ? true : false ;
end

def weekly_picks(week, locked)
	NflPick.joins(:nfl_matchup).where("pool_user_id = ? AND week = ? AND locked = ?", self.id, week, locked)
end

def total_score
	NflPick.where("pool_user_id = ? AND result = 'win'", self.id).count + NflPick.where("pool_user_id = ? AND result = 'tie'", self.id).count / 2.0
end

def nfl_survival_pick(week)
	NflPick.joins(:nfl_matchup).where("pool_user_id = ? AND week = ?", self.id, week).readonly(false).first
end

# PRIVATE METHODS
private

end

