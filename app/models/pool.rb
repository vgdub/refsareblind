class Pool < ActiveRecord::Base
# ASSOCIATIONS
	belongs_to :pool_type
	has_many :pool_users
	has_many :users, through: :pool_users

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

# CLASS METHODS

# INSTANCE METHODS

# PRIVATE METHODS
private

end
