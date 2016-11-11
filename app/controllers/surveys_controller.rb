class SurveysController < ApplicationController
  before_action :authenticate_user!
  
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
  	@survey = Survey.find(params[:id])
  end

  def edit
  	@survey = Survey.find(params[:id])
  end

  def update
  	@survey = Survey.find(params[:id])
  	@survey.update_attribute(:title, params[:survey][:title])
  	flash[:success] = "title updated successfully"
  	redirect_to survey_path(@survey)
  end

  private
  def survey_params
  	params.require(:survey).permit(:title)
  end

end
