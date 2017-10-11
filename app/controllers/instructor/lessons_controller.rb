class Instructor::LessonsController < ApplicationController

  def new
    # We need to pull in the section_id from the parameters
    @section = Section.find(params[:section_id])

    # Build a blank lesson to flesh out
    @lesson = Lesson.new

  end

  def create

    # Look up the section in the DB that this lesson is for
    @section = Section.find(params[:section_id])

    # Create the lesson in the DB and connect it to the section we looked up
    @lesson = @section.lessons.create(lesson_params)

    # Redirect to the instructor dashboard
    redirect_to instructor_course_path(@section.course)

  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end



end
