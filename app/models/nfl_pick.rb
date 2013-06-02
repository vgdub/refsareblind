class NflPick < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :user
	belongs_to :pool
	belongs_to :nfl_team

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
