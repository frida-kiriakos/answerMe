class HomeController < ApplicationController
  def index
  	if user_signed_in?
  	  @surveys = current_user.surveys
  	end
  end
end
