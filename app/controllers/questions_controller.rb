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
  	  	  redirect_to new_answer_path(question_id: @question.id)
  	  	end
  	  else
  	  	flash[:error] = "error saving question"
  	  	render 'new'
  	  end
  	end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.assign_attributes(question_params)
    if @question.answers_number_changed?
      old_n, new_n = @question.answers_number_change
      if !old_n.nil? and !new_n.nil? and old_n - new_n != 0
        if new_n >= old_n
          a_number = new_n - old_n
          a_number.times do
            a = @question.answers.build()
            a.save(validate: false)
          end
        else
          a_number = old_n - new_n
          a_number.times do
            @question.answers.last.destroy
          end
        end
      elsif new_n == 0
        old_n.times do
          @question.answers.last.destroy
        end
      end

    end

    if @question.save
      flash[:success] = "Question updated successfully"
      redirect_to survey_path(@question.survey_id)
    else
      flash[:error] = "Error updating question"
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Question deleted successfully"
    redirect_to survey_path(@question.survey_id)
  end
  
  private
  def question_params
  	params.require(:question).permit(:content, :answer_type, :answers_number)
  end
end
