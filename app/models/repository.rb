class Repository < ActiveRecord::Base

  attr_accessible :name, :description, :path

  has_many :projects, dependent: :destroy
  belongs_to :owner, class_name: "User"

  validates :owner, presence: true #unless: ->(n) { n.type == "Group" }
  validates :name, presence: true, uniqueness: true,
            length: { within: 0..255 }, 
            format: { with: /\A[a-zA-Z]+\z/,
    				message: "only allows letters" }
            		# message: "only letters, digits, spaces & '_' '-' '.' allowed."
  validates :tagline, length: { within: 0..255 }
  validates :description, length: { within: 0..255 }
  validates :path, uniqueness: true, presence: true, length: { within: 1..255 },
             format: { with: /\A[a-zA-Z]+\z/,
    				message: "only allows letters" }
                    # message: "only letters, digits & '_' '-' '.' allowed. Letter should be first" }

  delegate :name, to: :owner, allow_nil: true, prefix: true

  after_create :ensure_dir_exist
  after_update :move_dir, if: :path_changed?
  after_destroy :rm_dir

  scope :root, -> { where('type IS NULL') }

  def self.search query
    where("name LIKE :query OR path LIKE :query", query: "%#{query}%")
  end

  def to_param
    path
  end

  def ensure_dir_exist
    # DELETE /repos/:owner/self.path
  end

  def move_dir
  end

  def rm_dir
    # DELETE /repos/:owner/self.path
  end

end
