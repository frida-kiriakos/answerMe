class FilledSurvey < ApplicationRecord
  belongs_to :survey
  has_many :survey_answers, dependent: :destroy

  validates :survey_id, presence: true
end
