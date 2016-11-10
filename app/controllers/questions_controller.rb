class QuestionsController < ApplicationController
  def new
  	@survey = Survey.find(params[:survey_id])
  	@question = @survey.questions.build()
  end

  def create
  	@survey = Survey.find(params[:question][:survey_id])
  	if @survey
  	  @question = @survey.questions.build(question_params)
  	  if @question.save
  	    if @question.answer_type == "text"
  	  	  flash[:success] = "question is added, continue to adding questions or finish to publish your survey"
  	  	  redirect_to add_question_path(@question.survey_id)
  	  	else
  	  	  flash[:success] = "question is added, please enter possible answers"
  	  	  redirect_to new_answers_path(@question)
  	  	end
  	  else
  	  	flash[:error] = "error saving question"
  	  	render 'new'
  	  end
  	end
  end

  def new_answers
  	@question = Question.find(params[:question_id])
  	@question.answers_number.times {@question.answers.build()}
  end

  def add_answers
  	@question = Question.find(params[:question_id])
  	@question.answers_number.times {@question.answers.build()}
  	
  	begin
  	  @question.answers.each.with_index do |answer, i|
        answer.content = params["answers"]["content"][i]
        answer.save
  	  end
  	rescue
  	  flash[:error] = "Error adding answers"
  	  render 'new_answers'
  	else
  	  flash[:success] = "Answers added successfully"
  	  redirect_to add_question_path(@question.survey_id)
  	end
  end

  def destroy
  end
  
  private
  def question_params
  	params.require(:question).permit(:content, :answer_type, :answers_number)
  end

  def answer_params
  	params.require(:answer).permit(:content)
  end
end
