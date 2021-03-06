class Course < ApplicationRecord
  belongs_to :user, counter_cache: true

  has_many :lessons, dependent: :destroy, inverse_of: :course
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_many :course_tags, dependent: :destroy
  has_many :tags, through: :course_tags

  has_one_attached :logo

  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :language, :level, presence: true, length: { minimum: 5, maximum: 70 }
  validates :title, uniqueness: true
  validates :short_description, presence: true, length: { minimum: 5, maximum: 300 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :logo, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            size: { less_than: 500.kilobytes , message: 'Must be less 500 KB' },
            dimension: { width: { min: 250, max: 500 },
                         height: { min: 100, max: 500 }, message: 'Must be less 500 x 500 pixels' }

  # Validates with gem "active_storage_validations"
  # validates :logo, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  #           size: { less_than: 500.kilobytes , message: 'Must be less 500 KB' },
  #           dimension: { width: { min: 250, max: 500 },
  #                        height: { min: 100, max: 500 }, message: 'Must be less 500 x 500 pixels' }

  scope :top_rated, -> { order(average_rating: :desc, created_at: :desc).limit(3) }
  scope :popular, -> { order(enrollments_count: :desc, created_at: :desc).limit(3) }
  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  has_rich_text :description

  LANGUAGES = %i(English Russian)
  LEVELS = %i(Beginner Intermediate Advanced)

  def self.languages
    LANGUAGES.map { |lang| [lang, lang] }
  end

  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  def is_bought?(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).present?
  end

  def update_rating
    if self.enrollments.any? && self.enrollments.where.not(rating: nil).any?
      update_column :average_rating, (self.enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end

  def progress(user)
    unless self.lessons_count.zero?
      user_lessons.where(user: user).count / self.lessons_count.to_f * 100
    end
  end

  def calculate_income
    update_column :income, (enrollments.map(&:price).sum)
    user.calculate_course_income
  end
end
