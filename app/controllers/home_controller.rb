class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index privacy_policy]

  def index
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user})
                             .order(created_at: :desc).limit(3)
    @top_rated_courses = Course.top_rated.published.approved
    @popular_courses = Course.popular.published.approved
    @latest_courses = Course.latest.published.approved
    @latest_reviews = Enrollment.reviewed.latest_reviews
    @popular_tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc).limit(10)
  end

  def activity
    if current_user.has_role?(:admin)
      @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
    else
      redirect_to root_path, alert: "No access."
    end
  end

  def analytics
    redirect_to root_path, alert: "No access." unless current_user.has_role?(:admin)
  end

  def privacy_policy
  end
end
