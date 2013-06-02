class NflMatchup < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :home_team, class_name: "NflTeam", foreign_key: "home_team_id"
	belongs_to :away_team, class_name: "NflTeam", foreign_key: "away_team_id"
	has_many :nfl_picks

# VALIDATIONS
	after_save :score_nfl_picks_if_matchup_is_final

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
	def winning_team
		if self.final?
			return home_team_id if home_team_score > away_team_score + point_spread
			return away_team_id if away_team_score + point_spread > home_team_score
			return "tie" if home_team_score == away_team_score + point_spread
		else
			return nil
		end
	end


# PRIVATE METHODS
private
	def score_nfl_picks_if_matchup_is_final
		if self.final_changed? && self.final == true
			self.nfl_picks.each { |pick| pick.score_pick(self.winning_team) }
		end
	end

end
