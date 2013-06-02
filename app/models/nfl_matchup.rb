class NflMatchup < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :home_team, class_name: "NflTeam", foreign_key: "home_team_id"
	belongs_to :away_team, class_name: "NflTeam", foreign_key: "away_team_id"

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
