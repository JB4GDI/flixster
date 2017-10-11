class Instructor::LessonsController < ApplicationController

  # Make sure the user is logged in first
  before_action :authenticate_user!

  before_action :require_authorized_for_current_section

  def new

    # Build a blank lesson to flesh out
    @lesson = Lesson.new

  end

  def create

    # Create the lesson in the DB and connect it to the section we looked up
    @lesson = current_section.lessons.create(lesson_params)

    # Redirect to the instructor dashboard
    redirect_to instructor_course_path(current_section.course)

  end

  private

  def require_authorized_for_current_section

    # The user needs to own this lesson to work with it
    if current_section.course.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
    
  end

  helper_method :current_section
  def current_section
    # The ||= means to not look it up if we've found a value already.  It's 'memoization'
    # We need to pull in the section_id from the parameters
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end



end
