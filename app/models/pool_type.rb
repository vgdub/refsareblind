class PoolType < ActiveRecord::Base
# ASSOCIATIONS

# VALIDATIONS

# SPECIAL FEATURES

# SCOPES

# DELEGATIONS

# CALLBACKS

# CONFIG METHODS
	def to_s
		"#{sport} - #{name}"
	end

	def to_param
	end

# CLASS METHODS
	def self.survival
		self.where(name: "survival").first
	end

	def self.supercontest
		self.where(name: "supercontest").first
	end

# INSTANCE METHODS

# PRIVATE METHODS
private

end
