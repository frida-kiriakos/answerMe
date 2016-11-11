class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    if !@question.answers.blank?
      @question.answers.destroy_all
    end
    @question.answers_number.times do
      a = @question.answers.build()
      a.save
    end
  end

  def create
    print "answers-create \n"
    @question = Question.find(params[:answer][:question_id])
    begin
      @question.answers.each do |answer|
        answer.content = params['question']['answers']["#{answer.id}"]
        answer.save
      end
    rescue
      flash[:error] = "Error adding answers"
      render 'new'
    else
      flash[:success] = "Answers added successfully"
      redirect_to add_question_path(@question.survey_id)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
