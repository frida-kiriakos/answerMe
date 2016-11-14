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
        
        question = Question.find(id)
        
        if question.answer_type == "text"
          survey_answer.answer_id = 1  # is of dummy answer needed for validation purposes
          survey_answer.content = answers[id]
        else
          option = Answer.find(answers[id])
          survey_answer.answer_id = option.id
          survey_answer.content = option.content
        end
        
        survey_answer.save
      end

  	rescue
  	  flash['error'] = "Error saving survey"
  	  render 'new'
  	else
  	  flash['success'] = "Survey submitted successfully"
  	  redirect_to root_url
  	end
  end
end
