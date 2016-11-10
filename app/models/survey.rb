class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :filled_surveys

  validates :title, presence: true
end
