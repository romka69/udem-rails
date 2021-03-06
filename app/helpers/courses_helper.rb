module CoursesHelper
  def enrollment_button(course)
    if current_user

      if course.user == current_user
        link_to "You created this course. View analytics", course_path(course)
      elsif course.enrollments.where(user: current_user).any?
        "Learning progress: #{link_to number_to_percentage(course.progress(current_user), precision: 0),
                                      course_path(course)}"
      elsif course.price > 0
        link_to number_to_currency(course.price, locale: :en, precision: 0, delimiter: " "),
                new_course_enrollment_path(course), class: "btn btn-md btn-success"
      else
        link_to "Free", new_course_enrollment_path(course), class: "btn btn-md btn-success"
      end

    else
      link_to "Check price", new_course_enrollment_path(course), class: "btn btn-md btn-success"
    end
  end

  def review_button(course)
    user_course = course.enrollments.where(user: current_user)

    if current_user
      if user_course.any?
        if user_course.pending_review.any?
          "<hr> #{link_to 'Add a Review', edit_enrollment_path(user_course.first)}"
        else
          "<hr> You have left a #{link_to 'Review', enrollment_path(user_course.first)}"
        end
      end
    end
  end

  def certificate_button(course)
    user_course = course.enrollments.where(user: current_user)

    if user_course&.any?
      if course.progress(current_user) == 100
        "
          <div class='text-center py-2'>
            #{
              link_to certificate_enrollment_path(user_course.first, format: :pdf), class: 'btn btn-success' do
                'Certificate of completion'
              end
            }
          </div>
        "
      end
    end
  end
end
