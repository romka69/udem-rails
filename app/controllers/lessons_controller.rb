class LessonsController < ApplicationController
  before_action :set_course, only: %i[new create show edit update destroy]
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @lessons = Lesson.all
  end

  def show
    authorize @lesson
  end

  def new
    @lesson = Lesson.new
  end

  def edit
    authorize @lesson
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @lesson

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @lesson

    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :course_id)
    end
end
