class SurveysController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def new
  	@survey = current_user.surveys.new
  end

  def create
  end

  def show
  end

  def update
  end
end
