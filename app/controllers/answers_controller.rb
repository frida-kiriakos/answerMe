class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    if !@question.answers.blank?
      @question.answers.destroy_all
    end
    @question.answers_number.times do
      a = @question.answers.build()
      a.save(validate: false)
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
    @question = Question.find(params[:question_id])
    if @question.answers.blank?
      @question.answers_number.times do
        a = @question.answers.build()
        a.save(validate: false)
      end
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:answer][:question_id])
    begin
      @question.answers.each do |answer|
        answer.content = params['question']['answers']["#{answer.id}"]
        answer.save
      end
    rescue
      flash[:error] = "Error updating answers"
      render 'new'
    else
      flash[:success] = "Answers updated successfully"
      redirect_to survey_path(@question.survey_id)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    @question = @answer.question
    if  !@question.answers.blank? and @question.answers_number != 0
      @question.answers_number -= 1
      @question.save
    end
    if @question.answers_number <= 0
      redirect_to survey_path(@question.survey_id)
    else
      render 'edit'
    end
  end
end
