class SurveysController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def new
  	@survey = current_user.surveys.build()
  end

  def create
  	@survey = current_user.surveys.build(survey_params)

  	if @survey.save
  	  flash[:success] = "Survey created successfully, you can now add your questions"
  	  redirect_to add_question_path(@survey.id)
  	else
      render 'new'
    end
  end

  def show
  end

  def update
  end

  def add_question
  	print "survey_id " + params[:survey_id]
  end

  private
  def survey_params
  	params.require(:survey).permit(:title)
  end
end
