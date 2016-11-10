class SurveyAnswer < ApplicationRecord
  belongs_to :filled_survey
  belongs_to :question
  # belongs_to :answer

  validates :filled_survey_id, :question_id, :content, presence: true
end
