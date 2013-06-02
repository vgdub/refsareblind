class NflTeam < ActiveRecord::Base
# ASSOCIATIONS
	has_many :nfl_picks
	has_many :nfl_matchups, foreign_key: "home_team_id"
	has_many :nfl_matchups, foreign_key: "away_team_id"

# VALIDATIONS

# SPECIAL FEATURES

# SCOPES

# DELEGATIONS

# CALLBACKS

# CONFIG METHODS
	def to_s
	end

	def to_param
	end

# CLASS METHODS

# INSTANCE METHODS

# PRIVATE METHODS
private
end
