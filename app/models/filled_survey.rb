class FilledSurvey < ApplicationRecord
  belongs_to :survey
  has_many :survey_answers

  validates :survey_id, presence: true
end
