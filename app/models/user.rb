class User < ActiveRecord::Base
# ASSOCIATIONS
	has_many :pool_users, dependent: :destroy
	has_many :pools, through: :pool_users
	has_many :nfl_picks

# VALIDATIONS
	validates :email, presence: true, uniqueness: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "Email address is not formatted correctly" }

# SPECIAL FEATURES
	has_secure_password

# SCOPES

# DELEGATIONS
	def entries
		self.pool_users
	end

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
	def has_entry_in_pool?(pool_id)
		PoolUser.where("user_id = ? AND pool_id = ?", self.id, pool_id).present? ? true : false ;
	end

	def is_admin_of_pool?(pool_id)
		PoolUser.where("user_id = ? AND pool_id = ? AND role IN ('owner', 'admin')", self.id, pool_id).present? ? true : false ;
	end

# PRIVATE METHODS
private

end
