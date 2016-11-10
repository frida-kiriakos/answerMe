class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  validates :content, presence: true
  validates :answer_type, presence: true
end
