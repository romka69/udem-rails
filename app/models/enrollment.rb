class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true, on: :update
  validates :rating, :review, presence: true, on: :update
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validate :cant_subscribe_to_own_course

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    "#{user.username} - #{course.title}"
  end

  private

  def cant_subscribe_to_own_course
    if self.new_record?
      if user_id.present?
        if user_id == course.user_id
          errors.add(:base, "You can not subscribe to yor own course.")
        end
      end
    end
  end
end
