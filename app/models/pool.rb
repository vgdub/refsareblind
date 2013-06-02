class Pool < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :pool_type
	has_many :pool_users, dependent: :destroy
	has_many :users, through: :pool_users
	has_many :nfl_picks

# VALIDATIONS
	validates :name, presence: true, uniqueness: true
	validates :slug, presence: true, uniqueness: true

# SPECIAL FEATURES

# SCOPES
	scope :public, -> { where(public: true) }

# DELEGATIONS

# CALLBACKS
	before_validation on: :create do
		self.slug = self.name.parameterize if self.name.present?
	end

# CONFIG METHODS
	def to_s
		"#{name}"
	end

	def to_param
	end

	def destroy
		self.update_attribute("active", false)
	end

# CLASS METHODS

# INSTANCE METHODS
	def eliminated_users
		return users.select { |user| user.eliminated?(self.id) }
	end

	def remaining_users
		return users - eliminated_users
	end

# PRIVATE METHODS
private

end
