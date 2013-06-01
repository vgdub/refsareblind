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
	before_create :create_url_slug

# CONFIG METHODS
	def to_s
		"#{name}"
	end

	def to_param
	end

	def create_url_slug
		self.slug = self.name.parameterize
	end

# CLASS METHODS

# INSTANCE METHODS

# PRIVATE METHODS
private

end
