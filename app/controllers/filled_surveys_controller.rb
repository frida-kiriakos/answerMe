class FilledSurveysController < ApplicationController
  def new
  	@survey = Survey.find(params[:survey_id])
  	@filled_survey = @survey.filled_surveys.build()
  	@survey.questions.size.times {@filled_survey.survey_answers.build()}
  end

  def create
  	@survey = Survey.find(params[:filled_survey][:survey_id])
  	@filled_survey = @survey.filled_surveys.new()
    @filled_survey.save
  	begin
  	  params[:filled_survey][:survey_answers]['question_id'].each.with_index do |a, i|
  	    survey_answer = @filled_survey.survey_answers.new
  	    survey_answer.question_id = params[:filled_survey][:survey_answers]['question_id'][i]
  	    survey_answer.content = params[:filled_survey][:survey_answers]['content'][i]
  	    survey_answer.save
  	  end

  	rescue
  	  flash[:error] = "Error saving survey"
  	  render 'new'
  	else
  	  flash['success'] = "Survey submitted successfully"
  	  redirect_to root_url
  	end
  end
end
