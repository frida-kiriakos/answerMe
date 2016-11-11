class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent: :destroy
  validates :content, presence: true
  validates :answer_type, presence: true

  include ActiveModel::Dirty
end
