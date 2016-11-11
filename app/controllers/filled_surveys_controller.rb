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
      questions = params[:filled_survey][:survey_answers]['question_id']
      answers = Hash[questions.zip(params[:filled_survey][:survey_answers]['content'])]
      
      questions.each do |id|
        survey_answer = @filled_survey.survey_answers.new
        survey_answer.question_id = id
        survey_answer.content = answers[id]
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
