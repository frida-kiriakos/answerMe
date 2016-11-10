class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, unless: "question.answer_type == 'text'"
  
  
end
