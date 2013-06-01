class User < ActiveRecord::Base
# ASSOCIATIONS
	has_many :pool_users, dependent: :destroy
	has_many :pools, through: :pool_users

# VALIDATIONS
	validates :email, presence: true, uniqueness: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "Email address is not formatted correctly" }

# SPECIAL FEATURES
	has_secure_password

# SCOPES

# DELEGATIONS

# CALLBACKS

# CONFIG METHODS
	def to_s
		"#{firstname} #{lastname}"
	end

	def to_param
	end

	def destroy
		self.update_attribute("active", false)
	end

# CLASS METHODS

# INSTANCE METHODS

# PRIVATE METHODS
private

end
