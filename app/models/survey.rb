class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :filled_surveys, dependent: :destroy

  validates :title, presence: true
end
