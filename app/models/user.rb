class User < ApplicationRecord
  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def enrolled_in?(course)

    # Collect automatically builds an array to store these enrollment items
    # enrolled_courses = enrollments.collect do |enrollment|
    #   enrollment.course
    # end

    # And this is the shorthand of the code above
    # enrolled_courses = enrollments.collect(&:course)

    # But ultimately, we're going to do all the work in the has_many part at the top
    return enrolled_courses.include?(course)

  end

end
