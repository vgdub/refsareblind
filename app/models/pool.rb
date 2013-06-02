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
	def entries
		self.pool_users
	end

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
	def eliminated_entries
		return entries.select { |entry| entry.eliminated? }
	end

	def remaining_entries
		return entries - eliminated_entries
	end

	def ordered_standings
		return entries.sort_by { |entry| entry.total_score }.reverse
	end

# PRIVATE METHODS
private

end
