class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :new]
  before_action :load_answer, only: [:show, :edit, :update, :destroy]

  def new
    @answer = @question.answers.new
  end

  def show; end

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id if user_signed_in?

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy if @answer.user == current_user
    redirect_to question_path(@answer.question)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
